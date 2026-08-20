
terns = read.csv("data/2000-2023_ca_least_tern.csv")
str(terns)

colSums(is.na(terns))


# Visualizing Missing Data (13.4)

library("naniar")

vis_miss(terns)


gg_miss_fct(terns, year)


# Statistics with Missing Data (13.5)


terns$na_total_nests = is.na(terns$total_nests)
terns$na_fl_min = is.na(terns$fl_min)

imp_mean = terns

imp_mean$total_nests[terns$na_total_nests] =
  mean(imp_mean$total_nests, na.rm = TRUE)
imp_mean$fl_min[terns$na_fl_min] =
  mean(imp_mean$fl_min, na.rm = TRUE)

library("ggplot2")

ggplot(imp_mean) +
  aes(
    x = total_nests,
    y = fl_min,
    color = na_total_nests | na_fl_min
  ) +
  geom_point() +
  lims(x = c(0, 250), y = c(0, 250))

# Multiple Imputation (13.5.1)

library("mice")

imp = mice(terns, m = 3, method = "norm",
           printFlag = FALSE)

imp

vis_miss(complete(imp, 1))

fits = with(imp, lm(fl_min ~ total_nests))
fits

summary(pool(fits))

# Censored Data (14)
