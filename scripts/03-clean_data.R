#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
# Load necessary libraries
library(tidyverse)    # For data manipulation
library(lubridate)    # For handling dates

# Load the dataset
hate_crimes <- read_csv("data/01-raw_data/raw_data.csv")

# View the structure of the dataset to understand the columns
str(hate_crimes)

# Step 1: Filter Data Starting from 2018 (if not already done)
# Ensure that only data from 2018 onwards is included
hate_crimes_clean <- hate_crimes %>%
  filter(OCCURRENCE_YEAR >= 2018)

# Step 2: Handle Missing Values
# Check for missing values in key columns
colSums(is.na(hate_crimes_clean))

# We can decide to remove rows with missing values in important columns such as bias motivations
hate_crimes_clean <- hate_crimes_clean %>%
  filter(
    !is.na(OCCURRENCE_YEAR) &   # Ensure year is present
      (!is.na(RACE_BIAS) | !is.na(RELIGION_BIAS) | 
         !is.na(SEXUAL_ORIENTATION_BIAS) | !is.na(GENDER_BIAS) | 
         !is.na(AGE_BIAS) | !is.na(MENTAL_OR_PHYSICAL_DISABILITY) |
         !is.na(ETHNICITY_BIAS) | !is.na(LANGUAGE_BIAS))  # At least one bias motivation is present
  )

# Step 3: Standardize Bias Motivation Columns
# Create a unified BiasMotivation column based on all the different bias-related variables
hate_crimes_clean <- hate_crimes_clean %>%
  mutate(BiasMotivation = case_when(
    RACE_BIAS != "None" ~ "Race/Ethnicity",
    RELIGION_BIAS != "None" ~ "Religion",
    SEXUAL_ORIENTATION_BIAS != "None" ~ "Sexual Orientation",
    GENDER_BIAS != "None" ~ "Gender",
    AGE_BIAS == "YES" ~ "Age",
    MENTAL_OR_PHYSICAL_DISABILITY == "YES" ~ "Disability",
    ETHNICITY_BIAS != "None" ~ "Ethnicity",
    LANGUAGE_BIAS != "None" ~ "Language",
    TRUE ~ "Other"  # If no other biases, categorize as "Other"
  ))

# Step 4: Convert Dates to Date Format
# Ensure that dates are correctly formatted for any time-based analysis
hate_crimes_clean <- hate_crimes_clean %>%
  mutate(
    OCCURRENCE_DATE = as.Date(OCCURRENCE_DATE, format = "%Y-%m-%d"),
    REPORTED_DATE = as.Date(REPORTED_DATE, format = "%Y-%m-%d")
  )

# Step 5: Remove Unnecessary or Redundant Columns
# Keep only relevant columns for the analysis
hate_crimes_clean <- hate_crimes_clean %>%
  select(
    OCCURRENCE_YEAR, OCCURRENCE_DATE, REPORTED_DATE,
    BiasMotivation, PRIMARY_OFFENCE, NEIGHBOURHOOD_140, ARREST_MADE
  )

# Step 6: Remove Duplicates (if any)
hate_crimes_clean <- hate_crimes_clean %>%
  distinct()

# Step 7: Check the Final Cleaned Data
# View the first few rows of the cleaned data
head(hate_crimes_clean)

# View the structure of the cleaned data to ensure it is ready for analysis
str(hate_crimes_clean)

# Step 8: Save the Cleaned Data to a New CSV File
write_csv(hate_crimes_clean, "data/03-cleaned_data/cleaned_data.csv")
