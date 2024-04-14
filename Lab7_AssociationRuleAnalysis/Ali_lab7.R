# Make sure to set your own working directory
setwd("~/Desktop/CSCI-317_Computation-for-Scientific-Applications_Project-And-Labs/Lab7_AssociationRuleAnalysis")

# Installing required packages (uncomment if required)
# install.packages("arules")
# install.packages("foreign")

library(arules)
library(foreign)

# Load the ARFF file
data <- read.arff("diabetes.arff")

# Viewing first 5 rows of the dataset to make sure it was loaded properly
head(data)

# We need to convert numeric attributes to categorical for association rule mining
# Since I don't have specific domain knowledge, the ranges/values/thresholds might be inaccurate but are a good starting point
data$preg <- cut(data$preg, breaks=c(-Inf, 0, 3, 6, Inf), labels=c("None", "Low", "Medium", "High"))
data$plas <- cut(data$plas, breaks=quantile(data$plas, na.rm=TRUE), include.lowest=TRUE, labels=c("Low", "Medium-Low", "Medium-High", "High"))
data$pres <- cut(data$pres, breaks=quantile(data$pres, na.rm=TRUE), include.lowest=TRUE, labels=c("Low", "Medium-Low", "Medium-High", "High"))

data$skin <- factor(
  ifelse(data$skin == 0, "Not Measured",
         ifelse(data$skin < 20, "Low",
                ifelse(data$skin < 35, "Medium", "High")
         )
  )
)

data$insu <- factor(
  ifelse(data$insu == 0, "Not Measured",
         ifelse(data$insu < 94, "Low",
                ifelse(data$insu < 168, "Medium", "High")
         )
  )
)

data$mass <- cut(data$mass, breaks=quantile(data$mass, na.rm=TRUE), include.lowest=TRUE, labels=c("Low", "Medium-Low", "Medium-High", "High"))
data$pedi <- cut(data$pedi, breaks=quantile(data$pedi, na.rm=TRUE), include.lowest=TRUE, labels=c("Low", "Medium-Low", "Medium-High", "High"))
data$age  <- cut(data$age, breaks=c(-Inf, 25, 50, Inf), labels=c("Young", "Middle-Aged", "Senior"))

# Ensure all variables are converted to factors to avoid warnings
# Convert numeric columns to factors
convert_numeric_to_factor <- function(x) {
  if (is.numeric(x)) {
    x <- factor(x)
  }
  x
}
data[] <- lapply(data, convert_numeric_to_factor)

# Association rule analysis using apriori
# The thresholds/settings were set similar to the one used in Weka
rules <- apriori(data, parameter = list(supp = 0.1, conf = 0.9, target = "rules", maxlen = 10))
rules.sorted <- sort(rules, by = "confidence")

# Inspecting the top 10 rules
inspect(head(rules.sorted, n = 10))

# Save the rules to a file
write(rules, file="diabetes_rules.txt")

# View the dataset and rules for validation
head(data)
inspect(rules.sorted[1:10])

