% CSCI-317 Lab 2 - MatLab Loops and Vectors
% Author: Raja Allmdar Tariq Ali
% Date: 02/4/24

% Description: 
% Find a company that sells products related to your field of study
% (Computer Science)
% Select more than five different products as well as their price and
% quantity sold in 2017 (data can be made up)
% Use Vectors and Loops
% Complete the following :
% * Prepare data that is relevant to the tasks.
% * Find the average price of all products
% * Find how many products were sold at a price above the average price
% * Find the total income from transactions whose price is above the average price
% * Find the total income from each product
% * Find the total income generated from all sales


% Preparing the data and displaying it to the user
% Sources for shortlisting products (best selling PCs in 2017)
% * https://www.foxbusiness.com/markets/best-selling-pcs-of-2017
% * https://finance.yahoo.com/news/best-selling-pcs-2017-230300126.html
% The price and quantity for each product is hypothetical but looks real,
% fulfilling the requirements for the assignment
% Data is initialized using vectors
products = {'HP 8300 Elite Small Form Factor Desktop Computer', 'HP 22-b016 All-in-One desktop', 'HP Pavilion Power 580-023w Gaming Tower', 'Aspire E 15-inch notebook', 'HP 14 Inch "Stream" Laptop'};
price = [500, 450, 750, 600, 220];
quantity_2017 = [150000, 120000, 100000, 180000, 200000];

% Displaying the data using a for loop
% Also computing the average price of all products within the loop to 
% avoid using another for loop - less computationally intensive
disp("Initialized Product Data (2017):");
sumproducts = 0;
for i = 1:length(products)
    fprintf('Product = %s; Price = %.2f; Quantity = %d\n',products{i}, price(i), quantity_2017(i));
    sumproducts = sumproducts + price(i);
end

avgPriceAllProducts = sumproducts/length(products);
fprintf('\nThis is the average price of all products = %.3f\n', avgPriceAllProducts)

% Debug step to check if average calculated correctly
% disp(mean(price))


% Finding how many products were sold at a price above the average price (use
% a for loop)
% Also finding the total transactions above average price within this for
% loop instead of using another one - less computationally intensive
aboveAvgCount = 0;
TotalTransactionAboveAvg = 0;
for i = 1:length(price)
    if price(i) > avgPriceAllProducts
        aboveAvgCount = aboveAvgCount + 1;
        TotalTransactionAboveAvg = TotalTransactionAboveAvg + (price(i) * quantity_2017(i));
    end
end
fprintf('\nNumber of Products Sold Above Average Price: %d\n', aboveAvgCount);
fprintf('\nTotal Income from Above Average Price Sales: %f\n\n', TotalTransactionAboveAvg);


% Finding the total income from each product (use a for loop)
% Computing the total income generated from All Sales within the loop to
% avoid using another loop - less computationally intensive
disp('Total income from each product:')
totalIncomeAll = 0;
for i = 1:length(products)
    income = price(i) * quantity_2017(i);
    fprintf('%s: %f\n', products{i}, income);
    totalIncomeAll = totalIncomeAll + income;
end

fprintf('\nTotal Income from All Sales: %f\n', totalIncomeAll);

% Debug step to check if total income from All Sales is correct
% disp(sum(price .* quantity_2017))