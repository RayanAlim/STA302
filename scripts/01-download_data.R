#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto: Data is 2 datasets: Crime in neighbourhoods and neighbourhood profiles 
# Author: Rayan Awad Alim
# Date: 22 January 2024
# Contact: rayan.alim@mail.utoronto.ca 
# Pre-requisites: Install tidyverse and opendatatoronto
# License: MIT


#### Workplace setup ####
library(opendatatoronto)
library(tidyverse)

#### Download data: Neighborhood Crime Data ####

# get package
package <- show_package("neighbourhood-crime-rates")
package

# get all resources for this package
resources <- list_package_resources("neighbourhood-crime-rates")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
raw_crime_data <- filter(datastore_resources, row_number()==1) %>% get_resource()
raw_crime_data


#### Save data ####
write_csv(raw_crime_data, "inputs/data/unedited_crime_data.csv") 



#### Download data: Neighborhood Profiles Data ####


# get package
package <- show_package("6e19a90f-971c-46b3-852c-0c48c436d1fc")
package

# get all resources for this package
resources <- list_package_resources("6e19a90f-971c-46b3-852c-0c48c436d1fc")

# identify data resources and choose resource
selected_resource <- resources %>% 
  filter(id == "19d4a806-7385-4889-acf2-256f1e079060") %>% get_resource()


#### Save data ####
write_csv(raw_profiles_data, "inputs/data/unedited_neighbourhood_data.csv") 


