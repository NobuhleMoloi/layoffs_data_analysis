# Layoffs Data Analysis

## Project Overview
This project analyzes global layoffs data from March 2020 - March 2023 using SQL, focusing on both data cleaning and exploratory data analysis (EDA). The goal is to transform raw data into a structured format and extract meaningful patterns across companies, industries, countries, and time.

## Project Context
This project was developed as a guided exercise on Alex The Analyst’s SQL project: 
- Data Cleaning Project: https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/Portfolio%20Project%20-%20Data%20Cleaning.sql
- Exploratory Data Analysis Project: https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/Portfolio%20Project%20-%20EDA.sql
Additional independent queries and analysis were added to extend the exploration.

## Dataset
Dataset: [https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv]

## Tools Used
- SQL (MySQL)

## Data Cleaning Summary
The dataset was cleaned and prepared using the following steps:
- Created staging tables to preserve the original raw data
- Removed duplicate records using window functions
- Standardized text fields (company, industry, country)
- Converted date column from text to proper DATE format
- Handled missing and blank values
- Removed rows with insufficient data for analysis

## Exploratory Data Analysis (EDA)
The analysis focuses on identifying patterns in layoffs across multiple dimensions:
- Company: total layoffs vs percentage layoffs
- Country: geographic distribution of layoffs and shutdowns
- Industry: sector-level impact and shutdown frequency
- Time: yearly and monthly layoff trends
- Stage: comparison between early-stage and late-stage companies

## Key Insights
- Total layoffs and layoff percentages produce different company rankings, showing a difference between scale and severity of layoffs.
- The United States and India account for the highest total layoffs in the dataset.
- Finance, Retail, and Healthcare show higher average layoff percentages and higher shutdown counts compared to other industries.
- Layoff activity is concentrated in specific periods, with clear peaks rather than a steady distribution over time.
- Early-stage companies (Seed, Series A, Series B) show higher layoff percentages and more frequent shutdowns compared to later-stage companies.

## Limitations
- The dataset includes only reported layoffs and may not represent all global events.
- Some averages may be influenced by uneven sample sizes across countries, industries, and stages.

## Files in Repository
- `layoffs_data_cleaning.sql` — Data cleaning pipeline
- `layoffs_eda.sql` — Exploratory data analysis queries

## Author
Nobuhle Moloi
