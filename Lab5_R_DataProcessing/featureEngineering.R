# This function performs feature engineering, which is crucial for creating more accurate ML Models
# We add these interaction terms to capture the combined effects of these variables
# # For example, the risk of diabetes might be higher in individuals who have both high BMI and are older

featureEngineering <- function(data) {
  # Generating interaction terms
  data$age_bmi_interaction <- data$age * data$bmi
  data$hypertension_heart_interaction <- data$hypertension * data$heart_disease
  
  # Applying transformations
  data$log_bmi <- log(data$bmi + 1) # Adding 1 to avoid log(0)
  data$sqrt_age <- sqrt(data$age)
  
  return(data)
}
