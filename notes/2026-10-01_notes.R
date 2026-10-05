
squid = readRDS("data/1989-1994_ca_market_squid.rds")

str(squid)

summary(squid)

library("ggplot2")

ggplot(squid) + aes(x = mass_g) +
  geom_density() +
  geom_rug()

library("dplyr")

squid = filter_out(squid, mass_g >= 400 | is.na(mass_g))

nrow(squid)

ggplot(squid) + aes(x = mass_g) +
  geom_density() +
  geom_rug()

mean(squid$mass_g)


# Sampling Variation (7.2)

set.seed(1215)

sample1 = slice_sample(squid, n = 50)

sample1

summary(sample1$mass_g)

ggplot(sample1) + aes(x = mass_g) +
  geom_density() +
  geom_rug()


sample2 = slice_sample(squid, n = 50)
sample3 = slice_sample(squid, n = 50)

summary(sample2$mass_g)
summary(sample3$mass_g)

# The Bootstrap Algorithm (7.4)

mass_g = squid$mass_g
mean(mass_g)


boot = sample(mass_g, replace = TRUE)
ggplot(data.frame(x = boot)) +
  aes(x = x) +
  geom_density() +
  geom_rug()

mean(boot)


# 1. Resample from the original sample
# 2. Compute statistic of interest
# 3. Repeat that b = 1,000 times
# 4. Compute statistics or density of the
#    bootstrap estimates

library("purrr")

b = 1000
boot_resamples = map(1:b, \(i) {  # for (i in 1:b) {
  sample(mass_g, replace = TRUE)
})

length(boot_resamples)
class(boot_resamples)
boot_resamples[[1]]

boot_means = map_dbl(boot_resamples, mean)
boot_means

ggplot(data.frame(bootstrap_mean = boot_means)) +
  aes(x = bootstrap_mean) +
  geom_density() +
  geom_rug()

mean(mass_g)
sd(boot_means)


# Bootstrap Percentile Intervals (7.5)

quantile(boot_means, c(0.025, 0.975))


# The Central Limit Theorem (7.6)
# Hypothesis Tests

n = length(squid$mass_g)
std_err = sd(squid$mass_g) / sqrt(n)

std_err
mean(squid$mass_g) + qt(c(0.025, 0.975), n - 1) * std_err

qt(c(0.025, 0.975), n - 1)
