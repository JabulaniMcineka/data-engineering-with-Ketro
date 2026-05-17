"""
load_csv.py
───────────
Loads the PC sales CSV file into raw.pc_sales.
Run this AFTER 01_raw_schema.sql has been executed.

Usage:
    1. Put your CSV file in the data/ folder
    2. Run: python load_csv.py

Note: The CSV must have these exact headers in order:
Continent, Country or State, Province or City, Shop Name, Shop Age,
PC Make, PC Model, Storage Type, Customer Name, Customer Surname,
Customer Contact Number, Customer Email Address, Sales Person Name,
Sales Person Department, Cost Price, Sale Price, Payment Method,
Discount Amount, Purchase Date, Ship Date, Finance Amount, RAM,
Credit Score, Channel, Priority, Cost of Repairs,
Total Sales per Employee, PC Market Price, Storage Capacity
"""

import psycopg2
from pathlib import Path


BASE_DIR = Path(__file__).resolve().parent.parent

DB_CONFIG = {
    "host": "127.0.0.1",
    "port": 5432,
    "database": "health_db",
    "user": "postgres"
}

CSV_FILE = BASE_DIR / "data" / "pc_data.csv" 


def load_csv(conn, file_path):
    with open(file_path, "r", encoding="utf-8") as f:
        cursor = conn.cursor()
        try:
            cursor.copy_expert(
                """COPY raw.pc_sales (
                    continent, country_or_state, province_or_city,
                    shop_name, shop_age, pc_make, pc_model, storage_type,
                    customer_name, customer_surname, customer_contact_number,
                    customer_email_address, sales_person_name,
                    sales_person_department, cost_price, sale_price,
                    payment_method, discount_amount, purchase_date,
                    ship_date, finance_amount, ram, credit_score,
                    channel, priority, cost_of_repairs,
                    total_sales_per_employee, pc_market_price, storage_capacity
                ) FROM STDIN WITH CSV HEADER DELIMITER ','""",
                f
            )
            conn.commit()
            print(f"SUCCESS: loaded {file_path.name} → raw.pc_sales")
        except Exception as e:
            conn.rollback()
            print(f"ERROR: {e}")
        finally:
            cursor.close()


if __name__ == "__main__":
    print("=" * 55)
    print("LOADING RAW PC SALES DATA")
    print("=" * 55)

    conn = psycopg2.connect(**DB_CONFIG)
    load_csv(conn, CSV_FILE)

    with conn.cursor() as cur:
        cur.execute("SELECT COUNT(*) FROM raw.pc_sales;")
        count = cur.fetchone()[0]
        print(f"Rows loaded: {count}")

    print("\nNow run: python run_pipeline.py")
    conn.close()
