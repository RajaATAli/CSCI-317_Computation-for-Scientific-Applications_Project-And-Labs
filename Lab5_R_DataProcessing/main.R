# CSCI 317 Lab 5 - R Data Processing
# Author: Raja Allmdar Tariq Ali
# Date: 03/03/2024
# ----------------------------------------------------------------------------
# Problem Description: 
# * This R script performs data pre-processing, Exploratory Data Analysis (EDA),
# and one-hot encoding to prepare it for diabetes prediction 
# using a basic Random Forest ensemble model for Project 2
# * The goal is to accurately predict the presence of diabetes in individuals 
# by analyzing their health information
# * Data set: https://www.kaggle.com/datasets/iammustafatz/diabetes-prediction-dataset
# * This lab and project 2 is inspired by the research I have been involved in 
# for the past year with Dr Angela Murillo related to using Machine Learning and
# Deep Learning to predict the onset of diabetes (mostly Python)
# ----------------------------------------------------------------------------
# Make sure to set your own working directory
# setwd("~/Desktop/CSCI-317_Computation-for-Scientific-Applications_Project-And-Labs/Lab5_R_DataProcessing")

# Note to grader: If any of the required libraries are not installed on your system,
# please uncomment the install.packages() commands below to install it.

# install.packages("readr") # CSV files
# install.packages("dplyr") # data manipulation
# install.packages("fastDummies")

# Loading necessary libraries
library(readr)
library(dplyr)
library(fastDummies) # This library is used for one-hot encoding in ML Applications

# Loading user-defined functions from separate files (Sourcing)
source('filterOutliers.R')
source('summarizeDataset.R')
source('onehotEncoding.R')
source('featureEngineering.R')

# Importing data from local machine
data_filepath <- "diabetes_prediction_dataset.csv"
diabetes_data <- read_csv(data_filepath)


# Data Preprocessing

# Analyzing dataset, checking if it has any missing values and analyzing categorical variables
summarizeDataset(diabetes_data)

# Filtering outliers
diabetes_data <- filter_outliers(diabetes_data, "bmi")

# Applying one-hot encoding to categorical variables
# This will generate numerical columns for the Random Forest Ensemble model to interpret
diabetes_data <- onehotEncoding(diabetes_data, 
                                         exclude_col = "smoking_history", 
                                         exclude_value = "ever", 
                                         columns_to_encode = c("gender", "smoking_history"))

# Feature Engineering
diabetes_data <- featureEngineering(diabetes_data)

# Exporting the processed dataset as CSV
export_filepath <- "new_diabetes_dataset.csv"
write_csv(diabetes_data, export_filepath)

