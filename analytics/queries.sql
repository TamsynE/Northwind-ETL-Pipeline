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