#!/usr/bin/env Rscript
#
# This script cleans the Sacramento River (Hood Monitoring Station) water
# temperature dataset.

library("dplyr")
library("lubridate")
library("readr")


main = function(
  path = "data/dwr/Sac_Hood_Water_TempF_CSV.csv",
  out_path = "data/2010-2024_sacramento_river_hood_water_temp.rds"
) {
  hood = read_csv(path)

  hood = select(hood, 1:2)
  names(hood) = c("time", "temp_f")

  # Filter to 2010-2024.
  hood = filter(hood,
    year(time) >= 2010,
    year(time) <= 2024
  )

  saveRDS(hood, out_path)
}


main()
