
# Sacramento River Water Temperature Dataset

hood = readRDS("data/2010-2024_sacramento_river_hood_water_temp.rds")
hood

# Orange Tree Growth Dataset
Orange
orange = data.frame(Orange)

str(orange)

# Time Series (11)
# Cleaning

hood

library("ggplot2")

ggplot(hood) +
  aes(x = time, y = temp_f) +
  geom_line()

library("dplyr")

# Temperatures above boiling (212), below freezing (32)
print(filter(hood, temp_f < 32 | temp_f > 212), n = 30)
nrow(hood)

hood$temp_f[hood$temp_f < 32 | hood$temp_f > 212] = NA

ggplot(hood) +
  aes(x = time, y = temp_f) +
  geom_line()


library("tsibble")
hood = tsibble(hood, index = time)
hood

scan_gaps(hood)
hood = fill_gaps(hood)
hood

summary(hood)

hood$na_temp = is.na(hood$temp_f)
hood

library("forecast")
hood$temp_f = as.numeric(na.interp(hood$temp_f, linear = TRUE))

ggplot(hood) +
  aes(x = time, y = temp_f) +
  geom_line() +
  geom_point(
    data = filter(hood, na_temp),
    color = "red",
    size = 0.1
  )


# Decomposition (11.3)

library("ggtime")

gg_season(hood, temp_f, "1y")

gg_season(hood, temp_f, "1m")
gg_season(hood, temp_f, "1w")
gg_season(hood, temp_f, "1d")


library("feasts")

stl_fit = model(
  hood,
  stl = STL(
    temp_f ~ season("1y") + season("1d"),
    robust = TRUE
  )
)

report(stl_fit)

stl_cmp = components(stl_fit)
stl_cmp

autoplot(stl_cmp)


library("lubridate")

lims = make_datetime(2024, 1, c(1, 7))
lims

autoplot(stl_cmp, season_1d) +
  xlim(lims)

stl_fit = model(
  hood,
  stl = STL(
    temp_f ~ season("1y") +
      season("1d", window = "periodic"),
    robust = TRUE
  )
)

stl_cmp = components(stl_fit)
autoplot(stl_cmp)

autoplot(stl_cmp, season_1d) +
  xlim(lims)


# Autocorrelations (11.4)

hood_acf = ACF(hood, temp_f, lag_max = 48)
head(hood_acf)

autoplot(hood_acf)

hood_pacf = PACF(hood, temp_f, lag_max = 48)
autoplot(hood_pacf)

# Stationary Series

autoplot(hood, temp_f)


# Forecasting

hood23 = filter(stl_cmp, year(time) >= 2023)
hood23 = select(hood23, -.model)
head(hood23)

library("fable")

naive_fit = model(
  hood23,
  naive = NAIVE(temp_f)
)

naive_fcst = forecast(naive_fit, h = 24*3)

lims = tail(hood23$time, 1) + days(c(-29, 7))
lims

autoplot(naive_fcst) +
  autolayer(hood23, temp_f) +
  xlim(lims)

snaive_fit = model(
  hood23,
  snaive = SNAIVE(temp_f ~ lag("1y"))
)
snaive_fcst = forecast(snaive_fit, h = 24*3)

autoplot(snaive_fcst) +
  autolayer(hood23, temp_f) +
  xlim(lims)
