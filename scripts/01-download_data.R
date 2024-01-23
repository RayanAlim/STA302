#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto
# Author: Rayan Awad Alim
# Date: 22 January 2024
# Contact: rayan.alim@mail.utoronto.ca 
# Pre-requisites: Install tidyverse and opendatatoronto
# License: MIT


#### install Packages ####


#### Workplace setup ####
library(opendatatoronto)
library(tidyverse)

#### Download data ####
# get package
package <- show_package("neighbourhood-crime-rates")
package

# get all resources for this package
resources <- list_package_resources("neighbourhood-crime-rates")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
raw_data <- filter(datastore_resources, row_number()==1) %>% get_resource()
raw_data


#### Save data ####
write_csv(raw_data, "inputs/data/unedited_data.csv") 

         
