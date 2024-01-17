% CSCI-317 Lab 1 - MatLab Simple Program
% Personal Budget Planner
% Author: Raja Allmdar Tariq Ali
% Date: 01/21/24

% Problem Description:
% * This MATLAB script is designed as a Personal Budget Planner. 
% * The purpose of this program is to assist users in managing their
% personal finances by providing a clear overview of their monthly income, 
% expenses, and savings.
% * Users input their monthly income and expenses in multiple categories
% such as utilities, groceries, transportation, and others.
% * The program calculates the total expenses and determines the remaining
% balance from the monthly income.
% * It also provides insights into the user's spending habits by
% calculating the percentage of income spent on each expense category
% Additionally, the program allows users to set a savings goal and
% calculates how much they need to save each month to meet this goal.
% This, inturn, promotes better financial management and saving habits
% among its users

% Getting the current date as a string for user input
currentDate = datetime("today");

% Checking whether it is correct - debug step
% disp(currentDate)

% Extracting the month part - Converting the datetime objects to a string
dateString = datestr(currentDate, 'mmm');

% *Taking the necessary inputs from User, including monthly income, rent,
% utilities, groceries, transportation, and otherexpenses
monthly_income = input(['What was your monthly income (in $) for ', dateString, '? ']);
rent = input(['Enter your rent expenses for ', dateString, ' (in $): ']);
utilities = input(['Enter your utilities expenses for ', dateString, ' (in $): ']);
groceries = input(['Enter your groceries expenses for ', dateString, ' (in $): ']);
transportation = input(['Enter your transportation expenses for ', dateString, ' (in $): ']);
otherExpenses = input(['Enter your other expenses for ', dateString, ' (in $): ']);

% Calculating total expenses and remaining balance
totalExpenses = rent + utilities + groceries + transportation + otherExpenses;
remainingBalance = monthly_income - totalExpenses;

% Warning if expenses exceed income
if totalExpenses > monthly_income
    fprintf('\nWarning: Your expenses exceed your income by $%.2f!\n', abs(remainingBalance))
end

% Displaying Financial Summary
fprintf('\nFinancial Summary for the month of %s: \n', dateString);
fprintf('Total Income: $%.2f\n', monthly_income);
fprintf('Total Expenses: $%.2f\n', totalExpenses);
fprintf('Remaining Balance: $%.2f\n', remainingBalance);

% Calculating percentage breakdown of each expense category relative to total expenses
rentPercentage = (rent / totalExpenses) * 100;
utilitiesPercentage = (utilities / totalExpenses) * 100;
groceriesPercentage = (groceries / totalExpenses) * 100;
transportationPercentage = (transportation / totalExpenses) * 100;
otherExpensesPercentage = (otherExpenses / totalExpenses) * 100;


% Displaying the percentage breakdown
fprintf('\nPercentage Breakdown of expenses for the month of %s relative to total expenses: \n', dateString);
fprintf('Rent: %.2f%%\n', rentPercentage);
fprintf('Utilities: %.2f%%\n', utilitiesPercentage);
fprintf('Groceries: %.2f%%\n', groceriesPercentage);
fprintf('Transportation: %.2f%%\n', transportationPercentage);
fprintf('Other Expenses: %.2f%%\n', otherExpensesPercentage);