-- SQL Retail Sales Analysis - P1
CREATE DATABASE sql_project_p2;

-- Create TABLE
DROP TABLE IF EXISTS SALESS;
CREATE TABLE SALESS
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

SELECT TOP 10 * FROM SALESS

-- Data Cleaning


SELECT * FROM SALESS
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
--
    DELETE FROM SALESS
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;


-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM SALESS

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM SALESS



SELECT DISTINCT category FROM  SALESS


-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



 --  Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold
SELECT *
FROM saless
WHERE category = 'Clothing'
  and quantiy =3
  AND FORMAT(sale_date, 'yyyy-MM') = '2022-11';

  -- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select
category,
sum(total_sale) as tocag,
count(*) as toorders

from saless
group by category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select
avg(age) 

from saless
where category='beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select
*
from saless
where total_sale >1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select 
 category,
 gender,
 count(*) as total_trans
 
from saless
group by category,gender

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year


 select*
FROM (
  SELECT 
    YEAR(sale_date) AS year_sales,
    MONTH(sale_date) AS month_sales,
    AVG(total_sale) AS avg_sale,
   RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) sale_rank

  FROM saless
  GROUP BY 
    YEAR(sale_date), 
    MONTH(sale_date)
) T1
WHERE sale_rank = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select  top 5
customer_id,
sum(total_sale) as  a
from saless
group by customer_id
order by 1,2 desc

--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select
category ,
count(distinct customer_id) as  uniquecustomer
from saless
group by category

 --Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)




WITH hourly_sale
AS
(
SELECT *,
case 
when datepart(hour,sale_TIME)<12 then 'morning'
when datepart(hour,sale_TIME) between 12 and 17 then 'afternoon'
else 'evening'
END AS SHIFT
FROM SALESS
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

--end project


