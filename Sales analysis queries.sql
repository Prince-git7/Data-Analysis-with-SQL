# 1) What is the total revenue and total units sold overall?
SELECT 
  SUM(Revenue) AS total_revenue,
  SUM(Units_Sold) AS total_units_sold
FROM sales_data;

# 2) Revenue and units sold by Product — Top 5 products by revenue
SELECT Product, 
       SUM(Revenue) AS revenue,
       SUM(Units_Sold) AS units
FROM sales_data
GROUP BY Product
ORDER BY revenue DESC
LIMIT 5;

# 3) Revenue and units sold by Region
SELECT Region,
       SUM(Revenue) AS revenue,
       SUM(Units_Sold) AS units
FROM sales_data
GROUP BY Region
ORDER BY revenue DESC;

# 4) Compare total revenue and total units sold between online and offline channels.
SELECT 
    Channel,
    SUM(Revenue) AS total_revenue,
    SUM(Units_Sold) AS total_units,
    ROUND(AVG(Revenue / Units_Sold), 2) AS avg_price_per_unit
FROM sales_data
GROUP BY Channel
ORDER BY total_revenue DESC;

# 5) Revenue and units sold by Salesperson — top performers
SELECT Salesperson,
       SUM(Revenue) AS revenue,
       SUM(Units_Sold) AS units,
       COUNT(*) AS orders,
       ROUND(SUM(Revenue)/COUNT(*),2) AS avg_order_value
FROM sales_data
GROUP BY Salesperson
ORDER BY revenue DESC
LIMIT 5;

# 6) Which Channel (Online vs Offline) drives more revenue and which has higher AOV?
SELECT Channel,
       SUM(Revenue) AS revenue,
       COUNT(*) AS orders,
       ROUND(SUM(Revenue)/COUNT(*),2) AS AOV
FROM sales_data
GROUP BY Channel
ORDER BY revenue DESC;

# 7) Revenue split by Customer_Type (Retail vs Wholesale) and comparison of AOV
SELECT Customer_Type,
       SUM(Revenue) AS revenue,
       COUNT(*) AS orders,
       ROUND(SUM(Revenue)/COUNT(*),2) AS AOV
FROM sales_data
GROUP BY Customer_Type
ORDER BY revenue DESC;

# 8) Which products have the highest average price per unit (Revenue / Units_Sold)?
SELECT Product,
       SUM(Revenue) / SUM(Units_Sold) AS avg_price_per_unit,
       SUM(Revenue) AS total_revenue,
       SUM(Units_Sold) AS total_units
FROM sales_data
GROUP BY Product
HAVING SUM(Units_Sold) > 0
ORDER BY avg_price_per_unit DESC
LIMIT 5;

# 9) Find the top 3 products by revenue within each region.
SELECT 
    Region,
    Product,
    SUM(Revenue) AS total_revenue,
    RANK() OVER (PARTITION BY Region ORDER BY SUM(Revenue) DESC) AS product_rank
FROM sales_data
GROUP BY Region, Product
HAVING product_rank <= 3;

# 10) Find customers who generated more than the average total revenue.
WITH customer_sales AS (
    SELECT Salesperson, SUM(Revenue) AS total_revenue
    FROM sales_data
    GROUP BY Salesperson
)
SELECT 
    Salesperson,
    total_revenue
FROM customer_sales
WHERE total_revenue > (SELECT AVG(total_revenue) FROM customer_sales)
ORDER BY total_revenue DESC;
