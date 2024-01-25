#### Preamble ####
# Purpose: Cleans the raw data to see crime rate per neighborhood and crime type trends over the years
# Author: Rayan Awad Alim
# date: today
# date-format: long
# Contact: rayan.alim@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)

#Read raw crime data
crime_data <-
  read_csv(here::here("inputs/data/unedited_crime_data.csv"))


#### Cleaning Crime data ####

## Get yearly Average for all areas per crime type
# vector of years
years <-
  c("2014",
    "2015",
    "2016",
    "2017",
    "2018",
    "2019",
    "2020",
    "2021",
    "2022",
    "2023")

# Create an empty data frame to store the results
crime_type_averages <-
  data.frame(Crime_Type = character(),
             Year = character(),
             Average = double())

# Loop through each year and each crime type
for (year in years) {
  for (crime_type in c(
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
    column_name <- paste(crime_type, year, sep = "_")
    average_value <-
      sum(raw_crime_data[, column_name], na.rm = TRUE) / 158
    
    # Adding the result to the data frame
    crime_type_averages <-
      rbind(
        crime_type_averages,
        data.frame(
          Crime_Type = crime_type,
          Year = year,
          Average = average_value
        )
      )
  }
}

#Saving data frame as a csv file
write_csv(crime_type_averages, "outputs/data/crime_type_averages.csv")



# Aggregating Neighbourhood statistics
crime_data_cleaned <- crime_data %>%
  select(-starts_with("POPULATION_"), -ends_with("RATE_"), -geometry) %>%
  pivot_longer(cols = starts_with(
    c(
      "ASSAULT_",
      "AUTOTHEFT_",
      "BIKETHEFT_",
      "BREAKENTER_",
      "HOMICIDE_",
      "ROBBERY_",
      "SHOOTING_",
      "THEFTFROMMV_",
      "THEFTOVER_"
    )
  ),
  names_to = "Crime_Type_Year",
  values_to = "Count") %>%
  separate(Crime_Type_Year,
           into = c("Crime_Type", "Year"),
           sep = "_") %>%
  group_by(AREA_NAME, Crime_Type) %>%
  summarize(Total_Count = sum(Count, na.rm = TRUE))

# Saving as a new file
write_csv(crime_data_cleaned,
          "outputs/data/crime_data_cleaned_neighbourhood.csv")
