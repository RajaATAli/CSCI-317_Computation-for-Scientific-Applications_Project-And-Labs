# **Task 2 (Selecting Columns) and Task 11 (Visualization)**
# Purpose of performing task 2 and task 11:
# - Helps us understand the data distribution for the selected variables
# - Can help identify potential anomalies or outliers
# - Can further inform preprocessing steps as well as feature selection
# - The Kernerl Density Estimate will help us with the shape of the distribution (e.g. is it skewed or not?)

visualize_numerical_columns <- function(df, numerical_columns) {
  for (col_name in numerical_columns) {
    print(col_name)
    plot <- ggplot(df, aes_string(x = col_name)) +
      geom_histogram(aes(y = ..density..), binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
      geom_density(alpha = .2, fill = "red") +
      labs(title = paste(col_name, "Distribution with KDE"), x = col_name, y = "Density") +
      theme_minimal()
    print(plot)
  }
}