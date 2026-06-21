"""
run_pipeline.py
───────────────
Runs the full PC Sales star schema pipeline in order.
Same pattern as your health_db and deloitte-pipeline projects.

Usage:
    1. Load your CSV into raw.pc_sales first (via DBeaver or COPY command)
    2. Run: python run_pipeline.py

Pipeline order:
    01_raw_schema.sql      → create schemas and raw table
    02_dim_tables.sql      → create all 6 dimension tables
    03_fact_table.sql      → create fact_sales table
    04_populate_dims.sql   → fill dimension tables from raw data
    05_populate_facts.sql  → fill fact table + data quality checks
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

def run_schema(conn, file_path):
    with open(file_path, "r", encoding="utf-8") as f:
        sql_script = f.read()
    cursor = conn.cursor()
    try:
        cursor.execute(sql_script)
        conn.commit()
        print(f"  SUCCESS: {file_path.name}")
    except Exception as e:
        conn.rollback()
        print(f"  ERROR in {file_path.name}:")
        print(f"  {e}")
    finally:
        cursor.close()


if __name__ == "__main__":

    print("=" * 55)
    print("PC SALES STAR SCHEMA PIPELINE")
    print("=" * 55)

    conn = psycopg2.connect(**DB_CONFIG)

    with conn.cursor() as cur:
        cur.execute("SELECT current_database(), current_schema();")
        db, schema = cur.fetchone()
        print(f"Connected to: {db} (schema: {schema})")

    print("\nRunning pipeline scripts...")
    print("-" * 55)

    pipeline_files = [
        BASE_DIR / "sql/01_raw_schema.sql",
        BASE_DIR / "sql/02_dim_tables.sql",
        BASE_DIR / "sql/03_fact_table.sql",
        BASE_DIR / "sql/04_populate_dims.sql",
        BASE_DIR / "sql/05_populate_facts.sql",
    ]

    for file_path in pipeline_files:
        print(f"\nRUNNING: {file_path.name}")
        run_schema(conn, file_path)

    print("\n" + "=" * 55)
    print("Pipeline complete.")
    print("Open DBeaver → warehouse schema to explore results.")
    print("=" * 55)

    conn.close()
