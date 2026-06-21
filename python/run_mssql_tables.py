"""
run_mssql_tables.py
-------------------
Runs the SQL table creation and population scripts for Microsoft SQL Server.

Usage:
    1. Install the driver and dependency:
       pip install pyodbc
    2. Set environment variables (or edit the config below):
       MSSQL_SERVER, MSSQL_DATABASE, MSSQL_USER, MSSQL_PASSWORD
    3. Run:
       python python/run_mssql_tables.py
"""

from __future__ import annotations

import os
import re
from pathlib import Path

import pyodbc

BASE_DIR = Path(__file__).resolve().parent.parent
SQL_DIR = BASE_DIR / "sql"

SERVER = os.getenv("MSSQL_SERVER", "localhost")
DATABASE = os.getenv("MSSQL_DATABASE", "PC_Sales_Staging_dtw")
USER = os.getenv("MSSQL_USER", "sa")
PASSWORD = os.getenv("MSSQL_PASSWORD", "")
DRIVER = os.getenv("MSSQL_DRIVER", "{ODBC Driver 18 for SQL Server}")

TABLE_SCRIPT_ORDER = [
    "01_create_dim_customer.sql",
    "02_create_dim_product.sql",
    "03_create_dim_salesperson.sql",
    "04_create_dim_shop.sql",
    "05_create_dim_date.sql",
    "06_create_dim_paymentinfo.sql",
    "07_create_fact_sales.sql",
]


def split_sql_batches(sql_script: str):
    """Split a SQL script into executable batches using GO statements."""
    batches = [batch.strip() for batch in re.split(r"(?m)^\s*GO\s*$", sql_script)]
    return [batch for batch in batches if batch and not batch.startswith("--")]


def execute_sql_file(connection: pyodbc.Connection, file_path: Path):
    print(f"\nRunning: {file_path.name}")

    script = file_path.read_text(encoding="utf-8")
    batches = split_sql_batches(script)

    cursor = connection.cursor()
    try:
        for index, batch in enumerate(batches, start=1):
            cursor.execute(batch)
            print(f"  Batch {index}: executed successfully")
        connection.commit()
        print(f"  Completed: {file_path.name}")
    except Exception as exc:
        connection.rollback()
        print(f"  Error in {file_path.name}: {exc}")
        raise
    finally:
        cursor.close()


def main():
    connection_string = (
        f"DRIVER={DRIVER};"
        f"SERVER={SERVER};"
        f"DATABASE={DATABASE};"
        f"UID={USER};"
        f"PWD={PASSWORD};"
        f"TrustServerCertificate=yes;"
    )

    print("Connecting to SQL Server...")
    connection = pyodbc.connect(connection_string)

    try:
        cursor = connection.cursor()
        cursor.execute("SELECT @@SERVERNAME, DB_NAME();")
        server_name, db_name = cursor.fetchone()
        print(f"Connected to server: {server_name}")
        print(f"Connected database: {db_name}")
        cursor.close()

        for script_name in TABLE_SCRIPT_ORDER:
            script_path = SQL_DIR / script_name
            if not script_path.exists():
                print(f"Missing script: {script_path}")
                continue
            execute_sql_file(connection, script_path)

        print("\nAll table scripts completed successfully.")
    finally:
        connection.close()


if __name__ == "__main__":
    main()
