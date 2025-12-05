from extract import extract_all
import pandas as pd
import csv
import os

def transform(original):

    # 1. Customers Dimension
    dim_customers = original["customers"].copy()
    dim_customers = dim_customers.drop(['phone', 'fax'], axis=1)

    # 2. Products Dimension (Products + Categories)
    dim_products = original["products"].merge(
        original["categories"],
        how="left",
        left_on="categoryID",
        right_on="categoryID"
    )

    dim_products = dim_products.drop(
        ['supplierID', 'quantityPerUnit', 'description', 'picture', 'unitPrice', 'unitsInStock', 'unitsOnOrder', 'reorderLevel', 'discontinued'],
        axis=1
    )

    # 3. Employees Dimension
    dim_employees = original["employees"].copy()
    dim_employees['region'] = dim_employees['region'].fillna('UK')
    dim_employees = dim_employees.drop(
        ['titleOfCourtesy', 'homePhone', 'extension', 'photo', 'notes', 'photoPath'],
        axis=1
    )

    # 4. Order Fact (Orders + Order Details)
    fact_orders = original["order_details"].merge(
        original["orders"],
        how="left",
        on="orderID"
    )

    fact_orders['shipRegion'] = fact_orders['shipRegion'].fillna("Unknown")

    fact_orders['revenue'] = fact_orders['unitPrice'] * fact_orders["quantity"] * (1 - fact_orders["discount"])

    fact_orders = fact_orders.drop(
        ['requiredDate', 'shippedDate', 'shipVia', 'freight', 'shipName', 'shipAddress', 'shipCity', 'shipRegion', 'shipPostalCode', 'shipCountry'],
        axis=1
    )
    
    return {
        "dim_employees": dim_employees,
        "dim_customers": dim_customers,
        "dim_products": dim_products,
        "fact_orders": fact_orders
    }

def save_transformed(transformed, output_dir="./out"):

    os.makedirs(output_dir, exist_ok=True)

    for name, df in transformed.items():
        path = os.path.join(output_dir, f"{name}.csv")
        df.to_csv(path, index=False)

if __name__ == "__main__":
    raw_data = extract_all()
    transformed = transform(raw_data)
    save_transformed(transformed)
