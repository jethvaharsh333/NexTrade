import os
import pandas as pd
import requests
import pyodbc
import config

NSE_CSV_URL=config.NSE_CSV_URL
CSV_FILE_PATH=config.CSV_FILE_PATH
DATABASE_SERVER_NAME=config.DATABASE_SERVER_NAME
DATABASE_NAME=config.DATABASE_NAME
TABLE_NAME=config.TABLE_NAME

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
}

response = requests.get(NSE_CSV_URL, headers=HEADERS)

def download_csv():
    """Downloads the NSE stock data CSV file."""
    try:
        response = requests.get(NSE_CSV_URL, headers=HEADERS, timeout=10)
        response.raise_for_status()  # Raises HTTPError if status is 4xx/5xx
        
        with open(CSV_FILE_PATH, 'wb') as file:
            file.write(response.content)
        print("1. NSE CSV File Downloaded Successfully!")
        return True
    
    except requests.RequestException as e:
        print(f"Error downloading CSV: {e}")
        return False

def process_csv():
    if not os.path.exists(CSV_FILE_PATH):
        print("CSV file not found!")
        return None

    df = pd.read_csv(CSV_FILE_PATH)
    df.columns = df.columns.str.strip()  # Trim column names

    # Select relevant columns
    df = df[['NAME OF COMPANY','SYMBOL','DATE OF LISTING', 'FACE VALUE']]

    # Rename columns for database compatibility
    df.rename(columns={
        "NAME OF COMPANY": "StockName",
        "SYMBOL": "StockSymbol",
        "DATE OF LISTING": "DateOfListing",
        "FACE VALUE": "FaceValue"
    }, inplace=True)

    return df

def insert_into_database(df):
    try:
        conn = pyodbc.connect(
            "DRIVER={ODBC Driver 17 for SQL Server};"
            f"SERVER={DATABASE_SERVER_NAME};"
            f"DATABASE={DATABASE_NAME};"
            "Trusted_Connection=Yes;"
        )
        cursor = conn.cursor()
        print("2. Connected to MSSQL Database!")

        # Insert Data in Batch
        insert_query = f"""
            INSERT INTO {TABLE_NAME} (StockName, StockSymbol, DateOfListing, FaceValue)
            VALUES (?, ?, ?, ?)
        """
        cursor.executemany(insert_query, df.values.tolist())  # Batch insert
        conn.commit()
        conn.close()

        print("3. NSE stock data updated in MSSQL database!")
        return True
    except pyodbc.Error as e:
        print(f"Database error: {e}")
        return False

def listing_stocks_in_database():
    if not download_csv():
        return {"error": "Failed to download CSV"}

    df = process_csv()
    if df is None or df.empty:
        return {"error": "No valid stock data found"}

    if not insert_into_database(df):
        return {"error": "Database update failed"}

    return {"message": "Stock data updated successfully"}