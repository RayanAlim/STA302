#### Preamble ####
# Purpose: Tests for data validation on cleaned data
# Author: Rayan Awad Alim
# date: today
# date-format: long
# Contact: rayan.alim@mail.utoronto.ca
# License: MIT
# Pre-requisites: none


#### Workspace setup ####
library(tidyverse)

#### Test data ####

# Get cleaned crime data
crime_data_cleaned <-
  read_csv(here::here("outputs/data/crime_data_cleaned_neighbourhood.csv"))

# test for any missing values
if (any(is.na(crime_data_cleaned))) {
  warning("Missing values found in cleaned data")
}

# test thatdata is valid
if (any(crime_data_cleaned$Total_Count < 0)) {
  stop("Invalid total counts in the summarized data")
}

# test error handling for an invalid input File
tryCatch({
  read_csv("non_existent_file.csv")
}, error = function(e) {
  cat("Error in reading file: ", e$message, "\n")
})
