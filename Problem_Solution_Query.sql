CREATE DATABASE Retail_Sales_Analysis ;

USE Retail_Sales_Analysis ;

CREATE TABLE Retail_Sales(
transactions_id	INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id	INT,
gender	VARCHAR(15),
age	INT,
category VARCHAR(15),	
quantiy	INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
) ;


 #----- DATA CLEANING 
 
SELECT * FROM Retail_Sales LIMIT 10;

SELECT COUNT(transactions_id) from Retail_Sales ;

SELECT * FROM Retail_Sales
WHERE transactions_id IS NULL ;

SELECT * FROM retail_sales
WHERE
	transactions_id IS NULL
    OR 
   sale_date IS NULL
   OR 
   sale_time IS NULL
   OR 
   customer_id IS NULL
   OR 
   gender IS NULL
   OR 
   age IS NULL
   OR 
   category IS NULL
   OR 
   quantiy IS NULL 
   OR 
   price_per_unit IS NULL
   OR 
  cogs IS NULL
  OR 
  total_sale IS NULL ;
  


SELECT COUNT(*) FROM retail_sales ;

#----- DATA EXPLORATION

--- How many sales do we have ? 

SELECT COUNT(*) AS Retail_Sails FROM retail_sales;

--- How many customers do we have ?

SELECT COUNT(DISTINCT customer_id) AS COUNT_E_CUSTOMER FROM retail_sales ;

--- How many catagories do we have ?

SELECT DISTINCT category from retail_sales ;

#------ DATA ANALYSIS & BUSINESS PROBLEM SOLVING

--- Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05' ;

SELECT COUNT(*) FROM retail_sales
WHERE sale_date = '2022-11-05' ;

--- Write a SQL query to retrieve all transactions where the category is 'Clothing' and
-- the quantity sold is more than 4 in the month of Nov-2022 


SELECT *
FROM Retail_Sales
WHERE category = 'Clothing'
  AND quantiy > 4
  AND MONTH(sale_date) = 11
  AND YEAR(sale_date) = 2022;

--- write a query to calculate the total sales for each category.

select * from retail_sales ;

select category, sum(total_sale), count(*) as total_orders
from retail_sales
group by category ;

--- write a query to find the average age of customers who purchased items from the beauty category.

SELECT category, AVG(age) as Avg_age
FROM retail_sales
GROUP BY category ;

SELECT AVG(age)
FROM retail_sales 
WHERE category = 'Beauty';

---  write a query to find all transactions where the total sale is greater than 1000. 

SELECT * FROM retail_sales 
WHERE total_sale > 1000 ;

--- write a query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT
	category,
    gender,
	COUNT(*) AS Total_transactions
FROM retail_sales
GROUP BY
		category,
        gender
ORDER BY 1 ;

--- Write a query to calculate the avereage sale for each month. Find out best selling month in each year.

SELECT * FROM 
	(SELECT
		EXTRACT(YEAR FROM sale_date) AS Year,
		EXTRACT(MONTH FROM sale_date) AS Month,
		ROUND(AVG(total_sale),2) AS avg_sale,
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS DATA
FROM retail_sales
GROUP BY 1,2 )
AS T1
WHERE DATA = 1 ;


--- Write a query to find the top 5 customers based on the highest total sales.

select * from retail_sales ;

SELECT customer_id, SUM(total_sale) as total_sales
FROM retail_sales 
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5 ;


--- Write a query to find the number of unique customers who purchased items from each category.alter

SELECT 
	category,
    COUNT( DISTINCT customer_id) AS Unique_customers
FROM retail_sales
GROUP BY category ;

--- write a query to create each shift and number of orders (Morning <=12, Afternoon 12 to 17, Evening >17) 


SELECT
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
		END AS Shift,
        COUNT(*) AS Total_orders
FROM retail_sales
GROUP BY Shift
 ;
 
 --- End of Problem Statements ---













