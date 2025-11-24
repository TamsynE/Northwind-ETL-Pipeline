from extract import extract_all
import pandas as pd

def transform(original):

    # 1. Customers Dimension
    dim_customers = original["customers"].copy()
    dim_customers = dim_customers.drop(['phone', 'fax'], axis=1)

    # 2. Products + Categories Dimension
    dim_products = original["products"].merge(
        original["categories"],
        how="left",
        left_on="categoryID",
        right_on="categoryID"
    )
    dim_products = dim_products.drop(
        ['supplierID', 'quantityPerUnit', 'description', 'picture'],
        axis=1
    )

    # 3. Employees Dimension
    dim_employees = original["employees"].copy()
    dim_employees = dim_employees.drop(
        ['titleOfCourtesy', 'homePhone', 'extension', 'photo', 'notes', 'photoPath'],
        axis=1
    )

    # 4. Orders + Order Details Fact Table (not fully processed yet)
    fact_orders = original["order_details"].merge(
        original["orders"],
        how="left",
        on="orderID"
    )

    fact_orders = fact_orders.drop(
        ['requiredDate', 'shippedDate', 'shipVia', 'freight'],
        axis=1
    )

    print("Transformation complete.")
    
    return {
        "dim_employees": dim_employees,
        "dim_customers": dim_customers,
        "dim_products": dim_products,
        "fact_orders_raw": fact_orders      # Return this so you can inspect it!
    }


if __name__ == "__main__":
    raw_data = extract_all()

    print("\n=== RAW DATAFRAMES ===")
    for name, df in raw_data.items():
        print(f"\n{name} ({df.shape[0]} rows, {df.shape[1]} columns)")
        print(df.head())

    transformed = transform(raw_data)

    print("\n=== TRANSFORMED TABLES ===")
    for name, df in transformed.items():
        print(f"\n{name} ({df.shape[0]} rows, {df.shape[1]} columns)")
        print(df.head())
