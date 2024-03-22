# **Task 3 (Perform Computation) and Task 4 (Create New Columns)**
# Purpose of performing task 3 and task 4:
# - We will add a new column for Diabetes Risk Score (Not the same as an ML Model)
# - The risk score is calculated based on certain health indicators with specific weights
# - The weights are based on specfic domain knowledge

add_diabetes_risk_score <- function(df) {
  df %>%
    mutate(diabetes_risk_score = (0.5 * age) +          
             (2 * bmi) +            
             (1.5 * hypertension) + 
             (2 * heart_disease) +  
             (0.75 * blood_glucose_level))
}
