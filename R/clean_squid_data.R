#!/usr/bin/env Rscript
#
# This script cleans the CDFW's 1989-1994 market squid dataset, which is
# available at:
#
#   https://data.ca.gov/dataset/market-squid-fishery-historic-biological-samples-1989-1994-california
#

library("dplyr")
library("purrr")
library("readxl")
library("stringr")


tidy_names = function(x) {
  x = str_to_lower(x)
  x = str_replace_all(x, "[:space:]+", "_")
  x = str_replace_all(x, "[^[:alnum:]_]", "")
  x
}


clean_squid_data = function(
  path = "data/squid/MarketSquidFisheryDependentBiologicalSamples_1989-1994.xls"
) {
  squid = read_excel(path, .name_repair = tidy_names)

  names(squid)[1] = "sample_id"
  names(squid)[9] = "mass_g"

  squid$date = as.Date(squid$date)

  cat_cols = c("gear", "port", "sex", "maturity")
  squid[cat_cols] = map(squid[cat_cols], factor)

  saveRDS(squid, "data/1989-1994_ca_market_squid.rds")
}


clean_squid_data()
