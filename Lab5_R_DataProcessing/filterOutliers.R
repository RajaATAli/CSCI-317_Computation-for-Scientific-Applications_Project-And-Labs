# This function checks for detecting outliers and removing them from the dataset
filter_outliers <- function(data, column_name) {
  Q1 <- quantile(data[[column_name]], 0.25)
  Q3 <- quantile(data[[column_name]], 0.75)
  IQR <- Q3 - Q1
  lower_bound <- Q1 - 1.5 * IQR
  upper_bound <- Q3 + 1.5 * IQR
  filtered_data <- data %>% filter(data[[column_name]] >= lower_bound & data[[column_name]] <= upper_bound)
  return(filtered_data)
}
