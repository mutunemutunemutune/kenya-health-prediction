# Disease Incidence Forecasting in Kenya

## Project Overview
This project analyzes historical disease incidence data in Kenya to forecast future trends using time series models. The goal is to support public health planning and timely interventions through statistical forecasting.

## Project Structure
```
kenya-disease-forecasting/
│
├── data/
│   ├── raw_disease_incidence.csv    # Raw input data
│   └── processed_disease_incidence.csv  # Cleaned and processed data
├── analysis/
│   ├── data_preprocessing.R         # Data cleaning and preparation
│   └── disease_forecast_model.Rmd   # Main analysis notebook
├── visualizations/                  # Output plots and figures
├── README.md
└── .gitignore
```

## Data Structure
The dataset includes the following variables:
- `date`: Date of observation (YYYY-MM-DD)
- `cases`: Number of reported cases
- `region`: Geographic region (e.g., Nairobi, Mombasa)
- `region`: Geographic region (e.g., Nairobi, Mombasa)
- `disease_type`: Type of disease (e.g., HIV, Malaria)

## Setup Instructions
1. Install R and RStudio
2. Install required packages:
   ```R
   install.packages(c("tidyverse", "lubridate", "forecast", "ggplot2", "tseries",
                     "ggthemes", "plotly", "knitr", "kableExtra", "janitor"))
   ```
3. Run the preprocessing script:
   ```R
   source("analysis/data_preprocessing.R")
   result <- preprocess_disease_data(
     input_file = "data/raw_disease_incidence.csv",
     output_file = "data/processed_disease_incidence.csv"
   )
   ```
4. Run the analysis:
   ```R
   rmarkdown::render("analysis/disease_forecast_model.Rmd")
   ```

## Data Sources
- Kenya DHS via HDX: [DHS Kenya Dataset](https://data.humdata.org/dataset/kenya-dhs)
- CEMA Data Catalogue: [CEMA Africa](https://cema.africa/)
- KNBS Health Reports: [KDHS 2022](https://www.knbs.or.ke/)

## Analysis Components
1. **Data Preprocessing**
   - Data cleaning and standardization
   - Outlier detection and handling
   - Missing value imputation
   - Feature engineering for time series analysis

2. **Exploratory Data Analysis**
   - Time series visualization
   - Seasonal pattern analysis
   - Regional comparisons
   - Disease type comparisons

3. **Modeling**
   - ARIMA model fitting
   - Model evaluation and validation
   - Forecast generation
   - Performance metrics calculation

4. **Visualization**
   - Interactive time series plots
   - Forecast visualizations
   - Regional comparison charts
   - Seasonal decomposition plots

## License
This project is open source and available under the MIT License. 