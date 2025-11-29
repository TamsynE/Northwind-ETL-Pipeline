-- Monthly Revenue
SELECT
  EXTRACT(YEAR FROM orderdate) AS year,
  EXTRACT(MONTH FROM orderdate) AS month,
  SUM(revenue) AS total_revenue
FROM fact_sales
GROUP BY year, month
ORDER BY year, month;

-- Best-Selling Products
SELECT
  p.productname,
  SUM(f.quantity) AS total_units_sold,
  SUM(f.revenue) AS total_revenue
FROM fact_sales f
JOIN dim_products p
  ON f.productid = p.productid
GROUP BY p.productname
ORDER BY total_units_sold DESC
LIMIT 10;

-- Category Performance
SELECT
  p.categoryname,
  SUM(f.quantity) AS units_sold,
  SUM(f.revenue) AS revenue
FROM fact_sales f
JOIN dim_products p
  ON f.productid = p.productid
GROUP BY p.categoryname
ORDER BY revenue DESC;

-- Top Customers
SELECT
  c.customerid,
  c.companyname,
  SUM(f.revenue) AS total_revenue,
  COUNT(DISTINCT f.orderid) AS orders
FROM fact_sales f
JOIN dim_customers c
  ON f.customerid = c.customerid
GROUP BY c.customerid, c.companyname
ORDER BY total_revenue DESC
LIMIT 10;

-- Shipping Revenue by Country
SELECT
  c.country,
  SUM(f.revenue) AS revenue
FROM fact_sales f
JOIN dim_customers c
  ON f.customerid = c.customerid
GROUP BY c.country
ORDER BY revenue DESC;

-- Daily Sales Trend
SELECT
  orderdate,
  SUM(revenue) AS revenue
FROM fact_sales
GROUP BY orderdate
ORDER BY orderdate;

-- Revenue by Category over Time
SELECT
  EXTRACT(YEAR FROM f.orderdate) AS year,
  EXTRACT(MONTH FROM f.orderdate) AS month,
  p.categoryname,
  SUM(f.revenue) AS revenue
FROM fact_sales f
JOIN dim_products p
  ON f.productid = p.productid
GROUP BY year, month, p.categoryname
ORDER BY year, month, revenue DESC;

-- Top Sales per Employee
SELECT
  e.firstname || ' ' || e.lastname AS employee,
  SUM(f.revenue) AS revenue
FROM fact_sales f
JOIN dim_employees e
  ON f.employeeid = e.employeeid
GROUP BY employee
ORDER BY revenue DESC;




