# CSCI-317 Lab 4 - R Loops and Vectors
# Author: Raja Allmdar Tariq Ali
# Date: 02/25/24

# Description: 
# Find a company that sells products related to your field of study
# (Computer Science)
# Select more than five different products as well as their price and
# quantity sold in 2017 (data can be made up)
# Use Vectors and Loops
# Complete the following :
# * Prepare data that is relevant to the tasks.
# * Find the average price of all products
# * Find how many products were sold at a price above the average price
# * Find the total income from transactions whose price is above the average price
# * Find the total income from each product
# * Find the total income generated from all sales

# Preparing the data and displaying it to the user (more than 5 products)
# Sources for shortlisting products (best selling PCs in 2017)
# * https://www.foxbusiness.com/markets/best-selling-pcs-of-2017
# * https://finance.yahoo.com/news/best-selling-pcs-2017-230300126.html
# The price and quantity for each product is hypothetical but looks real,
# fulfilling the requirements for the assignment
# Data is initialized using vectors
products <- c('HP 8300 Elite Small Form Factor Desktop Computer', 'HP 22-b016 All-in-One desktop', 'HP Pavilion Power 580-023w Gaming Tower', 'Aspire E 15-inch notebook', 'HP 14 Inch "Stream" Laptop', 'Dell OptiPlex, Intel Core 2 Duo')
price <- c(500, 450, 750, 600, 220, 480)
quantity_2017 <- c(150000, 120000, 100000, 180000, 200000, 110000)

# Displaying the data using a for loop
# Also computing the average price of all products within the loop to 
# avoid using another for loop - less computationally intensive
cat("Initialized Product Data (2017):\n")
sumproducts <- 0
for (i in 1:length(products)) {
  cat(sprintf('Product = %s; Price ($) = %.2f; Quantity = %d\n', products[i], price[i], quantity_2017[i]))
  sumproducts <- sumproducts + price[i]
}
# Calculating and displaying the average price of all products, using the total sum of all prices divided by the number of products
avgPriceAllProducts <- sumproducts / length(products)
cat(sprintf('\nThis is the average price of all products ($) = %.3f\n', avgPriceAllProducts))

# Finding how many products were sold at a price above the average price (use
# a for loop)
# Also finding the total transactions above average price within this for
# loop instead of using another one - less computationally intensive
aboveAvgCount <- 0
TotalTransactionAboveAvg <- 0
for (i in 1:length(price)) {
  if (price[i] > avgPriceAllProducts) {
    aboveAvgCount <- aboveAvgCount + 1
    TotalTransactionAboveAvg <- TotalTransactionAboveAvg + (price[i] * quantity_2017[i])
  }
}
cat(sprintf('\nNumber of Products Sold Above Average Price: %d\n', aboveAvgCount))
cat(sprintf('\nTotal Income from Above Average Price Sales ($): %f\n\n', TotalTransactionAboveAvg))

# Finding the total income from each product (use a for loop)
# Computing the total income generated from All Sales within the loop to
# avoid using another loop - less computationally intensive
cat('Total income from each product:\n')
totalIncomeAll <- 0
for (i in 1:length(products)) {
  income <- price[i] * quantity_2017[i]
  cat(sprintf('%s: %f\n', products[i], income))
  totalIncomeAll <- totalIncomeAll + income
}

# Displaying the total income generated from all sales, summed up in the previous loop
cat(sprintf('\nTotal Income from All Sales ($): %f\n', totalIncomeAll))

# Debug step to check if total income from All Sales is correct
#cat(sum(price * quantity_2017))

