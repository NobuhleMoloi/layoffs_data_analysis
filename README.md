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

- Total layoffs and layoff percentages produce different company rankings, showing a clear distinction between absolute impact and workforce severity.
- The United States and India account for the highest total layoffs, indicating that layoff activity is heavily concentrated in a small number of countries.
- Finance, Retail, and Healthcare record both high average layoff percentages and high shutdown counts, making them the most consistently affected industries.
- Layoffs are concentrated in specific periods rather than evenly distributed, with peak activity observed during 2020 and early 2023.
- Early-stage companies (Seed, Series A, Series B) show higher layoff percentages and more frequent shutdowns compared to later-stage companies, indicating higher structural vulnerability.

## Limitations
- The dataset includes only reported layoffs and may not represent all global events.
- Some averages may be influenced by uneven sample sizes across countries, industries, and stages.

## Files in Repository
- `layoffs_data_cleaning.sql` — Data cleaning pipeline
- `layoffs_eda.sql` — Exploratory data analysis queries

## Author
Nobuhle Moloi
