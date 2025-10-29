🟩 VIEWS
1️⃣ monthly_sales_summary

--Shows month-wise total revenue and quantity sold.

CREATE VIEW monthly_sales_summary AS
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Year_Month,
    SUM(Revenue) AS Total_Revenue,
    SUM(Quantity) AS Total_Quantity
FROM sales_data
GROUP BY Year_Month
ORDER BY Year_Month;

2️⃣ top_customers

--Displays the top 5 customers by total revenue.

CREATE VIEW top_customers AS
SELECT 
    Customer_Name,
    SUM(Revenue) AS Total_Revenue
FROM sales_data
GROUP BY Customer_Name
ORDER BY Total_Revenue DESC
LIMIT 5;

🟦 STORED PROCEDURES
1️⃣ GetSalesByCustomer

--Fetches all sales records for a specific customer.

DELIMITER $$
CREATE PROCEDURE GetSalesByCustomer(IN cust_name VARCHAR(100))
BEGIN
    SELECT 
        Customer_Name, 
        Product, 
        Category, 
        Quantity, 
        Revenue, 
        Date
    FROM sales_data
    WHERE Customer_Name = cust_name
    ORDER BY Date;
END $$
DELIMITER ;

2️⃣ GetMonthlyRevenue

--Displays total monthly revenue for a selected year.

DELIMITER $$
CREATE PROCEDURE GetMonthlyRevenue(IN year_input INT)
BEGIN
    SELECT 
        DATE_FORMAT(Date, '%Y-%m') AS Month,
        SUM(Revenue) AS Total_Revenue
    FROM sales_data
    WHERE YEAR(Date) = year_input
    GROUP BY Month
    ORDER BY Month;
END $$
DELIMITER ;
