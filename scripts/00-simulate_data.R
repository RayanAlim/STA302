#### Preamble ####
# Purpose: Simulates the Neighbourhood crime rate dataset.
# Author: Rayan Awad Alim
# date: today
# date-format: long
# Contact: rayan.alim@mail.utoronto.ca
# Pre-requisites: Install tidyverse library
# License: MIT


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####

set.seed(23) #setting a random seed

simulate_data <- function(num_records = 158) {
  data <- tibble(
    AREA_NAME_id = 1:num_records,
    HOOD_ID = sample(100:999, num_records, replace = TRUE),
    POPULATION_2023 = sample(1000:50000, num_records, replace = TRUE),
  )
  
  for (year in 2014:2023) {
    for (crime in c(
      "ASSAULT",
      "AUTOTHEFT",
      "BIKETHEFT",
      "BREAKENTER",
      "HOMICIDE",
      "ROBBERY",
      "SHOOTING",
      "THEFTFROMMV",
      "THEFTOVER"
    )) {
      data[[paste(crime, year, sep = "_")]] <-
        sample(0:100, num_records, replace = TRUE)
      data[[paste(crime, "RATE", year, sep = "_")]] <-
        runif(num_records, 0, 1000)
    }
  }
  
  return(data)
}

# Generate the dataset
simulated_data <- simulate_data()


# Save the simulated dataset
write.csv(simulated_data,
          "inputs/data/simulated_crime_data.csv",
          row.names = FALSE)



#### Some data validation tests ####

#Check there are correct number of rows
if (nrow(simulated_data) != 158) {
  stop("Error: Data does not have the correct number of rows")
}

#Check All required columns are there
required_columns <- c("AREA_NAME_id", "HOOD_ID", "POPULATION_2023")
for (year in 2014:2023) {
  for (crime in c(
    "ASSAULT",
    "AUTOTHEFT",
    "BIKETHEFT",
    "BREAKENTER",
    "HOMICIDE",
    "ROBBERY",
    "SHOOTING",
    "THEFTFROMMV",
    "THEFTOVER"
  )) {
    required_columns <-
      c(
        required_columns,
        paste(crime, year, sep = "_"),
        paste(crime, "RATE", year, sep = "_")
      )
  }
}

#Check if there are missing required columns
if (!all(required_columns %in% names(simulated_data))) {
  stop("Error: Data is missing some required columns")
}
