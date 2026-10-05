
terns = read.csv("data/2000-2023_ca_least_tern.csv")

head(terns)

str(terns)

# Fixing data types
terns$site_name = factor(terns$site_name)

str(terns)


# as.numeric


dim(terns)
nrow(terns)
ncol(terns)
names(terns)


# Categorical Features (2)

head(terns$region_3)

library("dplyr")
kings = filter(terns, region_3 == "KINGS")
unique(kings$site_name)

nrow(terns)

library("ggplot2")

ggplot(terns) +
  aes(x = region_3) +
  geom_bar()

arizona = filter(terns, region_3 == "ARIZONA")
unique(kings$site_name)

# Mode
# For region_3, the mode is Southern

table(terns$region_3)


# Discrete features as categorical
head(terns$year)
terns$year

table(terns$year)

ggplot(terns) +
  aes(x = year) +
  geom_bar()

# Doesn't work as well for features that are
# "more numerical":
head(terns$total_nests)

ggplot(terns) +
  aes(x = total_nests) +
  geom_bar()


# Numerical Features (3)

# Binning
# Histogram (a binned bar plot)
ggplot(terns) +
  aes(x = total_nests) +
  geom_histogram(binwidth = 20)

ggplot(terns) +
  aes(x = total_nests) +
  geom_histogram(binwidth = 100, color = "black")


ggplot(terns) +
  aes(x = year) +
  geom_histogram(binwidth = 1, color = "black")

# The `cut` function bins data without plotting

ggplot(terns) +
  aes(x = bp_min) +
  geom_histogram(binwidth = 10)


# Density Plots
ggplot(terns) +
  aes(x = bp_min) +
  geom_density()


terns_region = filter(
  terns,
  region_3 %in% c("S.F._BAY", "CENTRAL",
                  "SOUTHERN")
)

terns_region

ggplot(terns_region) +
  aes(x = total_nests, color = region_3) +
  geom_density()


# Statistics for Numerical Features

# Location

# Mode tells us about where most likely data
# are

# Median - central data point
# -1 2 5 6
median(terns$total_nests)
median(terns$total_nests, na.rm = TRUE)

quantile(terns$total_nests, 0.5, na.rm = TRUE)
quantile(terns$total_nests, 0.25, na.rm = TRUE)

# Mean - balancing point
mean(terns$total_nests, na.rm = TRUE)


# Scale

# Interquartile Range (IQR)

quantile(terns$total_nests, na.rm = TRUE)
IQR(terns$total_nests, na.rm = TRUE)


# Standard Deviation

var(terns$total_nests, na.rm = TRUE)
sd(terns$total_nests, na.rm = TRUE)

