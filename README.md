# Northwind Retail ETL Pipeline & Analytics

## Overview

This project implements an end-to-end ETL (Extract, Transform, Load) pipeline using the Northwind Retail Dataset. The goal is to extract raw CSV data, clean and transform it using Python and Pandas, load it into Google BigQuery using a star schema, and perform analytics and visualization using SQL and Looker Studio.

The project demonstrates core data engineering and data warehousing concepts:

- ETL lifecycle

- Star schema and dimensional modeling

- Cloud-based analytics (BigQuery)

- SQL BI querying

- Dashboarding with Looker Studio


## Project Goals
- Build a complete ETL pipeline from raw CSVs to cloud analytics

- Design a star schema optimized for BigQuery

- Clean, transform, and integrate multi-table relational data

- Generate analytical metrics (e.g., revenue)

- Answer business intelligence questions (trends, top customers, categories, employees)

- Create a reusable, interactive dashboard

## Architecture
The project follows a traditional ETL architecture:

Raw CSVs → Extract (Python) → Transform (Pandas) → Load (BigQuery) → Analyze (SQL) → Visualize (Looker Studio)

### Star Schema

**Fact Table**: fact_orders (order-level line items)

**Dimension Tables**:

- dim_products

- dim_customers

- dim_employees

The fact table includes transaction-level metrics including quantity, price, discount, and computed revenue.
Dimension tables contain descriptive, slow-changing attributes for analysis.

### Technologies Used
| Component            | Technology      |
| -------------------- | --------------- |
| Programming          | Python, Pandas  |
| Cloud Data Warehouse | Google BigQuery |
| Visualization        | Looker Studio   |
| Data Modeling        | Star Schema     |
| Version Control      | Git / GitHub    |

## ETL Pipeline Description

#### 1. Extract

Implemented in `extract.py`

- Loads all CSV files into Pandas DataFrames

- Provides centralized access through a dictionary of tables

#### 2. Transform

Implemented in `transform.py`

Tasks performed:

- Clean missing values

- Remove irrelevant attributes

- Join tables for fact table creation

- Build dimension tables

- Compute revenue = unit_price × quantity × (1 – discount)

- Saves four cleaned output tables for loading

#### 3. Load (BigQuery)

- Manual load through BigQuery UI (future work includes automation)

- Automatic schema detection with manual correction when necessary

- Stored in a dedicated dataset for downstream analytics

#### 4. Analyze (SQL)

Queries include:

- Weekly, monthly, and daily revenue trends

- Top customers by revenue

- Best-selling products (revenue and units sold)

- Revenue by category and country

- Top employees

#### 5. Visualize (Looker Studio)

Built interactive dashboard using BigQuery saved views

Metrics include:

- Revenue trends

- Category distribution

- Top customers

- Top employees

- Best-selling products

### Sample Analytical Results

Highest weekly revenue: April 12, 1998 ($52,976.82)

Lowest weekly revenue: June 30, 1996 ($2,303.40)

Average weekly revenue: $13,049.41

Top category by revenue: Beverages, $267,868.18 (21.2%)

Top product: Côte de Blaye, $141,396.74

Top customer: QUICK-Stop, $110,277.31

Top employee: Margaret Peacock, $232,890.85

### Challenges

- Designing a proper star schema based on business questions

- BigQuery schema detection errors (requiring manual schema correction)

- Visualization issues due to date formatting + view recalculations

- Iterative adjustments to SQL queries to support dashboard requirements

### Future Improvements

- Automated ETL using Cloud Scheduler + Cloud Run

- Use Airflow for larger workflows (but unnecessary for this project scale)

- Add Date dimension + missing suppliers/regions/shippers tables

- Add profitability metrics: gross profit, profit margin, and discount analytics

- Implement historical forecasting (time series models)

### References
1. Northwind Retail Dataset

2. Google BigQuery Documentation

3. Cloud Run Documentation

4. Cloud Scheduler Documentation

5. Data Warehousing course materials
