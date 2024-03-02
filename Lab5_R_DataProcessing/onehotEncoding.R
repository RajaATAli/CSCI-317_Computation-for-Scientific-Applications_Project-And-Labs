# This function performs one-hot encoding on the dataset
# Basically converts categorical columns into a form that could be provided to ML Algorithms to better predict

onehotEncoding <- function(data, exclude_col = NULL, exclude_value = NULL, columns_to_encode) {
  # Optionally exclude rows based on a specific column's value
  if (!is.null(exclude_col) && !is.null(exclude_value)) {
    data <- data[data[[exclude_col]] != exclude_value, ]
    cat(sprintf("Excluded rows where `%s` is `%s`.\n", exclude_col, exclude_value))
  }
  
  # Apply one-hot encoding to specified columns
  data_encoded <- fastDummies::dummy_cols(data, select_columns = columns_to_encode, remove_selected_columns = TRUE)
  
  return(data_encoded)
}
