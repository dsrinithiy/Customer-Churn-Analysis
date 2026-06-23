create database churn_prediction;
USE churn_prediction;
SELECT COUNT(*) AS Total_Rows
FROM Churn_Modelling;

select * from Churn_Modelling;

-- CHECK THE NULL VALUES
SELECT
COUNT(*) AS Total_Rows,
COUNT(CustomerId) AS CustomerID_Count,
COUNT(CreditScore) AS CreditScore_Count,
COUNT(Age) AS Age_Count
FROM Churn_Modelling;

-- CHECK DUPLICATE VALUES
SELECT CustomerId,
COUNT(*) AS Duplicate_Count
FROM Churn_Modelling
GROUP BY CustomerId
HAVING COUNT(*) > 1;

-- CHECK DISTINCT COUNTRIES
SELECT COUNT(*) AS Churned_Customers
FROM Churn_Modelling
WHERE Exited = 1;

-- KPI TOTAL CUSTOMERS
SELECT COUNT(*) AS Total_Customers
FROM Churn_Modelling;

-- TOTAL CHURNED CUSTOMERS
SELECT COUNT(*) AS Churned_Customers
FROM Churn_Modelling
WHERE Exited = 1;

-- CHURN RATE
SELECT
ROUND(
(COUNT(CASE WHEN Exited=1 THEN 1 END)*100.0)
/COUNT(*),2
) AS Churn_Rate_Percentage
FROM Churn_Modelling;

-- AVERAGE CUSTOMER BALANCE
SELECT
ROUND(AVG(Balance),2) AS Avg_Customer_Balance
FROM Churn_Modelling;

-- ACTIVE MEMBER PERCENTAGE
SELECT
ROUND(
COUNT(CASE WHEN IsActiveMember = 1 THEN 1 END) * 100.0
/ COUNT(*), 0
) AS Active_Member_Percentage
FROM Churn_Modelling;

-- CHURN BY COUNTRY
SELECT
Geography,
COUNT(*) AS Customers,
SUM(Exited) AS Churned,
ROUND(SUM(Exited)*100.0/COUNT(*),2) AS Churn_Rate
FROM Churn_Modelling
GROUP BY Geography
ORDER BY Churn_Rate DESC;

-- CHURN BY GENDER
SELECT
Gender,
COUNT(*) AS Customers,
SUM(Exited) AS Churned,
ROUND(SUM(Exited)*100.0/COUNT(*),2) AS Churn_Rate
FROM Churn_Modelling
GROUP BY Gender;

-- AVERAGE AGE OF CHURNED CUSTOMER
SELECT
AVG(Age) AS Avg_Age_Churned
FROM Churn_Modelling
WHERE Exited=1;

-- CHURN BY AGE GROUP
SELECT
CASE
WHEN Age < 30 THEN 'Under 30'
WHEN Age BETWEEN 30 AND 40 THEN '30-40'
WHEN Age BETWEEN 41 AND 50 THEN '41-50'
ELSE 'Above 50'
END AS Age_Group,
COUNT(*) AS Customers,
SUM(Exited) AS Churned
FROM Churn_Modelling
GROUP BY
CASE
WHEN Age < 30 THEN 'Under 30'
WHEN Age BETWEEN 30 AND 40 THEN '30-40'
WHEN Age BETWEEN 41 AND 50 THEN '41-50'
ELSE 'Above 50'
END;

-- CHURN BY CREDICT SCORE
SELECT
CASE
WHEN CreditScore < 500 THEN 'Poor'
WHEN CreditScore BETWEEN 500 AND 700 THEN 'Average'
ELSE 'Good'
END AS Credit_Category,
COUNT(*) AS Customers,
SUM(Exited) AS Churned
FROM Churn_Modelling
GROUP BY
CASE
WHEN CreditScore < 500 THEN 'Poor'
WHEN CreditScore BETWEEN 500 AND 700 THEN 'Average'
ELSE 'Good'
END;

-- ACTIVE AND INACTIVE MEMBERS
SELECT
IsActiveMember,
COUNT(*) AS Customers,
SUM(Exited) AS Churned
FROM Churn_Modelling
GROUP BY IsActiveMember;
-- CREDICT CARD IMPACT
SELECT
HasCrCard,
COUNT(*) AS Customers,
SUM(Exited) AS Churned
FROM Churn_Modelling
GROUP BY HasCrCard;

-- CHURN BY NO.OF PRODUCTS:
SELECT
NumOfProducts,
COUNT(*) AS Customers,
SUM(Exited) AS Churned
FROM Churn_Modelling
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

-- TOP 10 HIGHEST BALANCED CUSTOMERS WHO CHURNED:
SELECT
    CustomerId,
    Balance,
    Age,
    Geography
FROM Churn_Modelling
WHERE Exited = 1
ORDER BY Balance DESC
LIMIT 10;

-- SALARY VS CHURN:
SELECT
CASE
WHEN EstimatedSalary < 50000 THEN 'Low Salary'
WHEN EstimatedSalary BETWEEN 50000 AND 100000 THEN 'Medium Salary'
ELSE 'High Salary'
END AS Salary_Group,
COUNT(*) AS Customers,
SUM(Exited) AS Churned
FROM Churn_Modelling
GROUP BY
CASE
WHEN EstimatedSalary < 50000 THEN 'Low Salary'
WHEN EstimatedSalary BETWEEN 50000 AND 100000 THEN 'Medium Salary'
ELSE 'High Salary'
END;

-- CUSTOMERS ABOVE AVERAGE BALANCE:
SELECT
CustomerId,
Balance
FROM Churn_Modelling
WHERE Balance >
(
SELECT AVG(Balance)
FROM Churn_Modelling
);

-- CUATOMERS ARE MORE LIKELY TO CHURN:
SELECT
CustomerId,
Age,
Balance,
CreditScore
FROM Churn_Modelling
WHERE Age >
(
SELECT AVG(Age)
FROM Churn_Modelling
)
AND CreditScore <
(
SELECT AVG(CreditScore)
FROM Churn_Modelling
);
