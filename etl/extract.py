import os
import pandas as pd

def load_csv(file_name, data_dir="./data"):
    """
    Loads a CSV file from the data directory and returns a pandas DataFrame.
    """
    file_path = os.path.join(data_dir, file_name)
    try:
        df = pd.read_csv(file_path)
        print(f"Loaded {file_name} with {len(df)} rows.")
        return df
    except FileNotFoundError:
        print(f"File not found: {file_path}")
        return pd.DataFrame() # return empty


def extract_all(data_dir="./data"):
    """
    Loads all raw CSV files into a dictionary of DataFrames.
    """
    data = {
        "categories": load_csv("categories.csv", data_dir),
        "customers": load_csv("customers.csv", data_dir),
        "employees": load_csv("employees.csv", data_dir),
        "order_details": load_csv("order_details.csv", data_dir),
        "orders": load_csv("orders.csv", data_dir),
        "products": load_csv("products.csv", data_dir),
    }
    return data


if __name__ == "__main__":
    data = extract_all()
    print(data)
    print("Data extraction complete.")

