# This function summarizes the dataset, including analyzing categorical variables as well

summarizeDataset <- function(data) {
  # Summary of the dataset
  cat("Summary of Dataset:\n")
  print(summary(data))
  
  # Printing the number of columns in the data set
  cat("\nThese are the number of columns in the dataset:\n")
  print(colnames(data))
  
  # Printing the number of people with and without diabetes
  cat("\nThese are the number of people with and without diabetes:\n")
  print(table(data$diabetes))
  
  # Check for missing values
  missing_values <- sapply(data, function(column) sum(is.na(column)))
  cat("\nMissing values in each column:\n")
  print(missing_values)
  
  # Analyzing Categorical variables
  cat("\nData distribution of categorical columns:\n")
  # Identify categorical columns
  categorical_columns <- sapply(data, is.character)
  cat_columns <- names(data)[categorical_columns]
  
  # Iterating through each categorical column to print its distribution
  for (col in cat_columns) {
    cat(sprintf("This is the data distribution of categorical column `%s`:\n", col))
    print(table(data[[col]]))
    cat(strrep("-", 50), "\n") # For easier identification
  }
  
}
