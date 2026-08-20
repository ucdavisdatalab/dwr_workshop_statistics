squid = readRDS("data/1989-1994_ca_market_squid.rds")

library("dplyr")

squid = filter_out(squid, mass_g >= 400 | is.na(mass_g))

squid

# Hypothesis: do male and female squid differ in dorsal mantle length?

# Formal hypotheses:
# H0: mean_f == mean_m
# HA: mean_f != mean_m

# Test statistic
difference_of_fm_lengths = function(data) {
  # Get the groups
  female = filter(data, sex == "Female")
  male = filter(data, sex == "Male")
  
  length_f = mean(female$dorsal_mantle_length_mm)
  length_m = mean(male$dorsal_mantle_length_mm)
  
  length_f - length_m
}

fm_length_diff = difference_of_fm_lengths(squid)

set.seed(12099)

library("purrr")

perm_resamples = map(1:10000, \(i) {
  samp = squid
  samp$sex = sample(samp$sex)
  samp
})

head(perm_resamples[[1]]$sex)
head(squid$sex)

difference_of_fm_lengths(perm_resamples[[1]])
perm_fm_length_diffs = map_dbl(perm_resamples, difference_of_fm_lengths)

library("ggplot2")

ggplot(data.frame(difference_of_means = perm_fm_length_diffs)) +
  aes(x = difference_of_means) +
  geom_density() +
  geom_rug() +
  geom_vline(xintercept = fm_length_diff)


# Discernibility level 0.05
pval = ecdf(perm_fm_length_diffs)(fm_length_diff)

# Reject the null hypothesis!

# Linear Models (9)

ggplot(squid) +
  aes(x = dorsal_mantle_length_mm, y = mass_g) +
  geom_point(alpha = 0.5)

squid_cloud = filter(
  squid,
  dorsal_mantle_length_mm < 200,
  mass_g < 150
)
ggplot(squid_cloud) +
  aes(x = dorsal_mantle_length_mm, y = mass_g) +
  geom_point(alpha = 0.5)

model = lm(mass_g ~ dorsal_mantle_length_mm, squid)
model

# Model Diagnostics (9.3)
squid$predicted_mass_g = predict(model)
ggplot(squid) +
  aes(x = dorsal_mantle_length_mm, y = mass_g - predicted_mass_g) +
  geom_point()

ggplot(squid) +
  aes(x = predicted_mass_g, y = mass_g - predicted_mass_g) +
  geom_point()

library("ggfortify")

autoplot(model)


model = lm(mass_g ~ dorsal_mantle_length_mm, squid_cloud)
model

autoplot(model)


quad_model = lm(
  mass_g ~ dorsal_mantle_length_mm + I(dorsal_mantle_length_mm^2),
  squid_cloud
)
quad_model

autoplot(quad_model)


# Interpreting Models (9.5)
summary(model)
