from extract import extract_all

def clean_df(df):
    pass

def transform(df):
    pass

if __name__ == "__main__":
    raw_data = extract_all()
    transformed = transform(raw_data)

    print("Transformation complete. Tables available:")
    for name in transformed.keys():
        print(f" - {name}")