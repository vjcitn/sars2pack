context("Data retrieval from web")

library(yaml)
yml = yaml.load_file(system.file(package='sars2pack', path='data_catalog/dataset_details.yaml'))
dsets = yml$datasets

skp = c("economist_excess_deaths", "google_search_trends_data", "apple_mobility_data",
   "google_mobility_data", "cdc_us_linelist_data") # too big
skpe = c("cci_us_vaccine_data", "econ_tracker_employment_national_data",
"econ_tracker_employment_city_data", "econ_tracker_employment_state_data",
"econ_tracker_consumer_spending_national_data",
"econ_tracker_employment_county_data")  # error 28 Mar


for(dset in names(dsets)) {
  if (dset %in% c(skp, skpe)) next
  print("===")
  print(dset)
  print("===")
                                        #if(dset=='apple_mobility_data') next ## skip for now
  accessor = get(dset)
  res = accessor()
                                        # skip non-data-frame-like objects for now
  if(inherits(res,'data.frame')) {
    context(sprintf("%s columns and datatypes",dset))
    cnames = colnames(res)
    test_that(paste0(dset, " column names match"),
              expect_equal(cnames, names(dsets[[dset]]$columns)))
    ctypes = lapply(res, class)
    test_that(paste0(dset, " column types match"),
              expect_equal(ctypes, dsets[[dset]]$columns))
  }
}
