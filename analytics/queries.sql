-- Best Selling Products
SELECT
  p.productname AS product_name,
  p.categoryName AS category,
  SUM(f.quantity) AS total_units_sold,
  ROUND(SUM(f.revenue),2) AS total_revenue
FROM `etl-project-478115.Northwind.fact_orders` f
JOIN `etl-project-478115.Northwind.dim_products` p
  ON f.productid = p.productid
GROUP BY product_name, category
ORDER BY total_units_sold DESC;

-- Category Performance
SELECT p.categoryName as category,
  SUM(f.quantity) AS units_sold,
  ROUND(SUM(f.revenue),2) AS revenue 
FROM `etl-project-478115.Northwind.fact_orders` f
JOIN `etl-project-478115.Northwind.dim_products` p
  ON f.productid = p.productid
GROUP BY p.categoryName
ORDER BY revenue DESC;

-- Country Revenue
SELECT
  c.country,
  ROUND(SUM(f.revenue),2) AS revenue
FROM `etl-project-478115.Northwind.fact_orders` f
JOIN `etl-project-478115.Northwind.dim_customers` c
  ON f.customerID = c.customerID
GROUP BY c.country
ORDER BY revenue DESC;

-- Daily Revenue
SELECT
  EXTRACT(DAY FROM orderDate) AS day,
  EXTRACT(YEAR FROM orderDate) AS year,
  EXTRACT(MONTH FROM orderDate) AS month,
  ROUND(SUM(revenue),2) AS total_revenue
FROM `etl-project-478115.Northwind.fact_orders` 
GROUP BY day, year, month
ORDER BY day, year, month;

-- Weekly Revenue
SELECT
  DATE_TRUNC(orderdate, WEEK) AS week_start,
  ROUND(SUM(revenue), 2) AS total_revenue
FROM `etl-project-478115.Northwind.fact_orders`
GROUP BY week_start
ORDER BY week_start;

-- Monthly Revenue
SELECT
  EXTRACT(YEAR FROM orderDate) AS year,
  EXTRACT(MONTH FROM orderDate) AS month,
  ROUND(SUM(revenue),2) AS total_revenue
FROM `etl-project-478115.Northwind.fact_orders` 
GROUP BY year, month
ORDER BY year, month;

-- Top Customers
SELECT
  c.customerID as customer_id,
  c.companyName as company,
  ROUND(SUM(f.revenue),2) AS total_revenue,
  COUNT(DISTINCT f.orderid) AS num_orders
FROM `etl-project-478115.Northwind.fact_orders` f
JOIN `etl-project-478115.Northwind.dim_customers` c
  ON f.customerID = c.customerID
GROUP BY c.customerID, c.companyName
ORDER BY total_revenue DESC
LIMIT 10;

-- Top Employees
SELECT
  CONCAT(e.firstname, ' ', e.lastname) AS employee,
  e.title,
  ROUND(SUM(f.revenue),2) AS revenue
FROM `etl-project-478115.Northwind.fact_orders` f
JOIN `etl-project-478115.Northwind.dim_employees` e
  ON f.employeeID = e.employeeID
GROUP BY employee, title
ORDER BY revenue DESC;

-- Average Daily Revenue
WITH daily_revenue AS (
  SELECT
    EXTRACT(YEAR FROM orderDate) AS year,
    EXTRACT(MONTH FROM orderDate) AS month,
    EXTRACT(DAY FROM orderDate) AS day,
    SUM(revenue) AS total_revenue
  FROM `etl-project-478115.Northwind.fact_orders`
  GROUP BY year, month, day
)
SELECT
  ROUND(AVG(total_revenue), 2) AS avg_daily_revenue
FROM daily_revenue;

-- Average Monthly Revenue
WITH monthly_revenue AS (
  SELECT
    EXTRACT(YEAR FROM orderDate) AS year,
    EXTRACT(MONTH FROM orderDate) AS month,
    SUM(revenue) AS total_revenue
  FROM `etl-project-478115.Northwind.fact_orders`
  GROUP BY year, month
)
SELECT
  ROUND(AVG(total_revenue), 2) AS avg_monthly_revenue
FROM monthly_revenue;

-- Average Weekly Revenue
WITH weekly_revenue AS (
  SELECT
    DATE_TRUNC(orderdate, WEEK) AS week_start,
    SUM(revenue) AS total_revenue
  FROM `etl-project-478115.Northwind.fact_orders`
  GROUP BY week_start
)
SELECT
  ROUND(AVG(total_revenue), 2) AS avg_weekly_revenue
FROM weekly_revenue;

-- Max, Min, Average Daily Revenue
(SELECT
  EXTRACT(YEAR FROM orderDate) AS year,
  EXTRACT(MONTH FROM orderDate) AS month,
  EXTRACT(DAY FROM orderDate) AS day,
  ROUND(SUM(revenue),2) AS total_revenue
FROM `etl-project-478115.Northwind.fact_orders` 
GROUP BY year, month, day
ORDER BY total_revenue
LIMIT 1)
UNION ALL
(SELECT
  EXTRACT(YEAR FROM orderDate) AS year,
  EXTRACT(MONTH FROM orderDate) AS month,
  EXTRACT(DAY FROM orderDate) AS day,
  ROUND(SUM(revenue),2) AS total_revenue
FROM `etl-project-478115.Northwind.fact_orders` 
GROUP BY year, month, day
ORDER BY total_revenue DESC
LIMIT 1)

-- Max, Min, Average Monthly Revenue
(SELECT
  EXTRACT(YEAR FROM orderDate) AS year,
  EXTRACT(MONTH FROM orderDate) AS month,
  ROUND(SUM(revenue),2) AS total_revenue
FROM `etl-project-478115.Northwind.fact_orders` 
GROUP BY year, month
ORDER BY total_revenue
LIMIT 1)
UNION ALL
(SELECT
  EXTRACT(YEAR FROM orderDate) AS year,
  EXTRACT(MONTH FROM orderDate) AS month,
  ROUND(SUM(revenue),2) AS total_revenue
FROM `etl-project-478115.Northwind.fact_orders` 
GROUP BY year, month
ORDER BY total_revenue DESC
LIMIT 1)

-- Max, Min, Average Weekly Revenue
(SELECT
  DATE_TRUNC(orderdate, WEEK) AS week_start,
  ROUND(SUM(revenue), 2) AS total_revenue
FROM `etl-project-478115.Northwind.fact_orders`
GROUP BY week_start
ORDER BY total_revenue DESC
LIMIT 1)
UNION ALL
(SELECT
  DATE_TRUNC(orderdate, WEEK) AS week_start,
  ROUND(SUM(revenue), 2) AS total_revenue
FROM `etl-project-478115.Northwind.fact_orders`
GROUP BY week_start
ORDER BY total_revenue ASC
LIMIT 1);
