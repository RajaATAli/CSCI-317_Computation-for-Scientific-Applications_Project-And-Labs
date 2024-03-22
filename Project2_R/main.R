# CSCI 317 Project 2 - R
# Author: Raja Allmdar Tariq Ali
# Date: 03/24/2024
# ----------------------------------------------------------------------------
# Problem Description: 
# * The purpose of this analysis is to understand and predict diabetes risk 
# based on health indicators using a dataset with 100,000 entries related to diabetes.
# * The goal is to accurately predict the presence of diabetes in individuals 
# by analyzing their health information
# * Data set: https://www.kaggle.com/datasets/iammustafatz/diabetes-prediction-dataset
# * The above dataset was cleaned in Lab 5 (mainly one-hot encoding and outliers removed)
# * The dataset contains the following columns:
#   -  gender, age, hypertension, heart_disease, smoking_history, bmi, 
#   - HbA1c_level, blood_glucose_level, and diabetes.
# * Project 2 is inspired by the research I have been involved in 
# for the past year with Dr Angela Murillo related to using Machine Learning and
# Deep Learning to predict the onset of diabetes (mostly Python)
# ----------------------------------------------------------------------------

# Make sure to set your own working directory
setwd("~/Desktop/CSCI-317_Computation-for-Scientific-Applications_Project-And-Labs/Project2_R")

# Loading libraries (Note to grader: please make sure packages are installed)
library(readr)
library(dplyr)
library(ggplot2)

# Loading functions
source("task2_11.R")
source("task3_4.R")



diabetes_df <- read_csv("new_diabetes_dataset.csv")

# Exploring the Dataset
str(diabetes_df) 
summary(diabetes_df) 
head(diabetes_df)

# Check for missing values
colSums(is.na(diabetes_df))

# Task 2 and 11
# List of numerical columns for which we want to create histograms with KDE
numerical_columns <- c("age", "hypertension", "heart_disease", "bmi", "HbA1c_level", "blood_glucose_level", "diabetes")
visualize_numerical_columns(diabetes_df, numerical_columns)

# Task 3 & 4
diabetes_df <- add_diabetes_risk_score(diabetes_df)
# Making sure new column was created
colnames(diabetes_df)

# **Task 6 (applying some functions on data)**
# Purpose of performing task 6:
# - Normalize the age and bmi columns to ensure that these features are on a similar scale
# - This is useful for distance-based algorithms in ML as it prevents variables with 
# larger ranges from dominating those with smaller ranges
# Apply Functions on Data - Normalizing age and bmi
# Normalize function scales the data between 0 and 1
normalize <- function(x) { (x - min(x)) / (max(x) - min(x)) }

# Normalizing 'age' and 'bmi' columns
diabetes_df <- diabetes_df %>%
  mutate(age_normalized = normalize(age),
         bmi_normalized = normalize(bmi))

# Ensuring the new columns were created correctly
colnames(diabetes_df)

# **Task 10 (Binning)** 
# Purpose of performing task 10:
# - This will categorize age into different groups
# - This could help in understanding the distribution of diabetes across different age groups

# Binning age into categories
diabetes_df$age_group <- cut(diabetes_df$age,
                             breaks = c(0, 18, 30, 45, 60, 75, Inf),
                             labels = c("0-18", "19-30", "31-45", "46-60", "61-75", "76+"),
                             include.lowest = TRUE)
# Viewing the distribution of age groups
table(diabetes_df$age_group)

# **Task 12 (Sampling)**
# Purpose of performing task 12:
# - We will create a sample of the dataset to test models
# - Useful in handling large datasets by reducing the computational load for model training
# Creating a sample of 1000 entries for inital model testing
set.seed(317) # Ensure reproducibility
sampled_df <- sample_n(diabetes_df, 1000)

# **Task 13 (Counting)**
# Purpose of performing task 13:
# - We'll count the number of individuals with and without diabetes
# - Useful for checking if the dataset is imbalanced or not
# Counting the number of individuals with and without diabetes
diabetes_counts <- table(diabetes_df$diabetes)
print(diabetes_counts)
# Ensuring the age_group column was created correctly and viewing the first few rows
head(diabetes_df)
# Printing the structure of the sampled data
str(sampled_df)

# **Task 5 (Change Column Types)**
# Purpose of performing task 5:
# - facilitates certain types of analysis or visualization that work better with categorical data
# Changing 'diabetes' from numeric to factor
diabetes_df$diabetes <- as.factor(diabetes_df$diabetes)

# Exporting the full modified dataset
write_csv(diabetes_df, "modified_diabetes_dataset.csv")

