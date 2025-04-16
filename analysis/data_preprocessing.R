# Data Preprocessing Script for Disease Incidence Analysis
# This script handles data collection, cleaning, and preparation for analysis

# Load required packages
library(tidyverse)
library(lubridate)
library(readxl)
library(janitor)

# Function to clean and standardize disease data
clean_disease_data <- function(data) {
  data %>%
    clean_names() %>%  # Standardize column names
    mutate(
      date = as.Date(date),
      month = month(date, label = TRUE),
      year = year(date),
      quarter = quarter(date),
      cases = as.numeric(cases),
      region = str_to_title(region),
      disease_type = str_to_title(disease_type)
    ) %>%
    filter(!is.na(cases)) %>%  # Remove missing values
    arrange(date)  # Sort by date
}

# Function to handle outliers
handle_outliers <- function(data, threshold = 3) {
  data %>%
    group_by(region, disease_type) %>%
    mutate(
      z_score = (cases - mean(cases)) / sd(cases),
      cases = ifelse(abs(z_score) > threshold, 
                    mean(cases) + sign(z_score) * threshold * sd(cases),
                    cases)
    ) %>%
    select(-z_score)
}

# Function to impute missing values
impute_missing_values <- function(data) {
  data %>%
    group_by(region, disease_type, month) %>%
    mutate(
      cases = ifelse(is.na(cases),
                    mean(cases, na.rm = TRUE),
                    cases)
    ) %>%
    ungroup()
}

# Function to create time series features
create_time_features <- function(data) {
  data %>%
    mutate(
      time_index = as.numeric(date - min(date)),
      month_sin = sin(2 * pi * month(date) / 12),
      month_cos = cos(2 * pi * month(date) / 12),
      year_sin = sin(2 * pi * year(date) / max(year(date))),
      year_cos = cos(2 * pi * year(date) / max(year(date)))
    )
}

# Main preprocessing function
preprocess_disease_data <- function(input_file, output_file) {
  # Read the data
  raw_data <- read.csv(input_file)
  
  # Apply preprocessing steps
  processed_data <- raw_data %>%
    clean_disease_data() %>%
    handle_outliers() %>%
    impute_missing_values() %>%
    create_time_features()
  
  # Save processed data
  write.csv(processed_data, output_file, row.names = FALSE)
  
  # Return summary statistics
  summary_stats <- processed_data %>%
    group_by(region, disease_type) %>%
    summarise(
      n_observations = n(),
      start_date = min(date),
      end_date = max(date),
      mean_cases = mean(cases),
      sd_cases = sd(cases),
      min_cases = min(cases),
      max_cases = max(cases)
    )
  
  return(list(
    data = processed_data,
    summary = summary_stats
  ))
}

# Example usage:
# result <- preprocess_disease_data(
#   input_file = "data/raw_disease_incidence.csv",
#   output_file = "data/processed_disease_incidence.csv"
# ) 