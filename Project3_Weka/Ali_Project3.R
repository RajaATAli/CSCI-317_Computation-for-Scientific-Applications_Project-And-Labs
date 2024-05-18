# Name: Raja Allmdar Tariq Ali
# Purpose: * This script performs a cluster analysis on a dataset of diabetes patients
# * The objective is to identify patterns and group similar cases based on health metrics like BMI, blood glucose levels, etc.
# * Insights from this analysis may assist in targeted healthcare strategies and understanding patient subgroups.

# Make sure to set your own working directory!
# setwd("~/Desktop/CSCI-317_Computation-for-Scientific-Applications_Project-And-Labs/Project3_Weka")
install.packages("foreign")
library(foreign)
dataset <- read.arff("cleaned_diabetes_converted.arff")

normalize <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}

# Applying normalization
dataset_norm <- as.data.frame(lapply(dataset[, c("age", "bmi", "hba1c_level", "blood_glucose_level")], normalize))

# Combining into one data frame
dataset_final <- cbind(dataset_norm, dataset[, c("hypertension", "heart_disease", "diabetes", "gender_female", "gender_male", "gender_other", "smoking_history_noinfo", "smoking_history_current", "smoking_history_former", "smoking_history_never", "smoking_history_notcurrent")])


set.seed(123)  # For reproducibility
kmeans_result <- kmeans(dataset_final, centers=2, nstart=25)  # nstart to try multiple initial centroids

print(kmeans_result$centers)  # Print cluster centroids
table(kmeans_result$cluster)  # Frequency table of clusters


install.packages("ggplot2")
library(ggplot2)
# Plotting key features against each other w/colors to visualize separation
ggplot(dataset_final, aes(x=age, y=bmi, color=factor(kmeans_result$cluster))) + geom_point(alpha=0.5) + labs(color='Cluster')

