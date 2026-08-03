# PC Sales Data Pipeline

An end-to-end SQL data pipeline that ingests, cleans, models, and analyses
PC retail sales data using SQL Server, following a layered (raw → staging →
clean → dimensional model → analysis view) architecture.

## Project Structure

```
PC-Data-Task/
├── README.md
├── data/
│   └── pc_data.csv
└── sql/
    ├── create_database.sql
    ├── load_raw_data.sql
    ├── create_staging_tables.sql
    ├── data_quality_checks.sql
    ├── create_clean_table.sql
    ├── data_modelling.sql
    ├── create_view.sql
    └── analysis.sql
```

## Pipeline Overview

```
Raw CSV → Raw/Landing Table → Staging Table → Data Quality Checks
        → Clean Table → Dimensional Model (Star Schema) → Flat View → Analysis
```

| Layer | Table | Description |
|---|---|---|
| 1 | `raw_pc_data` | Exact, permanent copy of the source CSV. Loaded once, never truncated or modified. All columns NVARCHAR. |
| 2 | `stg_pc_data` | Working copy rebuilt from raw as many times as needed during cleaning. Freely truncatable. |
| 3 | `clean_pc_data` | Typed (DATE, DECIMAL, INT), with known bad values filtered or flagged rather than guessed. |
| 4 | Star schema | `FactPCSales` plus 8 dimension tables, enforcing one row per unique combination of dimension keys and dates. |
| 5 | `vw_PCSalesFlat` | Flat view joining the fact table to all dimensions, for simple, readable analysis queries. |

## Approach and Why

**Why a raw/landing layer, separate from staging?**
The raw table is loaded once and never modified, so there is always an
unaltered copy of exactly what was delivered — independent of anything
that happens during cleaning. Staging is rebuilt from raw as many times
as needed, so a bad cleaning rule can always be corrected by re-running
from raw, without needing to re-locate or re-import the original file.

**Why fix data quality issues before modelling, not after?**
Every downstream table — clean, dimensions, fact — is only as reliable
as the data it's built from. Fixing categorical typos, format
inconsistencies, and invalid values as early as possible means the star
schema reflects genuinely clean data rather than baking bad values into
permanent surrogate keys.

**Why exclude and flag invalid data rather than guess a default?**
Several issues in this dataset have no way to be corrected with
confidence — there's no reliable way to know what a `Payment_Method` of
`452` was supposed to mean, or what a customer's actual surname was when
the row structurally doesn't represent an individual customer at all. In
these cases, the pipeline excludes the row from the affected
table/fact and logs it to a `DataQuality_*` table, rather than silently
defaulting to a plausible-looking but fabricated value.

**Why NULL-safe joins in the fact table load?**
Several dimension attributes (e.g. `Customer_Email_Address`,
`Sales_Person_Department`) can be genuinely NULL. In SQL, `NULL = NULL`
is never true, so a plain equality join silently drops every row
containing a NULL in any joined column — this was found to be dropping
the entire fact table during this build. Joins use
`ISNULL(a, sentinel) = ISNULL(b, sentinel)` so two NULLs are correctly
treated as a match.

**Why require `Purchase_Date` but not `Ship_Date` in the fact table?**
`Ship_Date` is missing for the large majority of rows. Requiring both
dates cut the fact table down to under 5% of the source data — an
unreasonable loss for what is very likely, in large part, genuinely
unshipped or untracked orders rather than corrupted data. `Purchase_Date`
is required (a sale without a purchase date isn't a usable fact);
`Ship_Date` is retained as NULL where genuinely unknown.

## Data Quality Issues Found

### Resolved
- **Embedded header rows** — the source CSV contained literal header
  rows (e.g. a row where every value equals its own column name) mixed
  into the data, likely from concatenating multiple export batches.
  Removed during the staging build.
- **Date format mismatch** — `TRY_CONVERT(date, ...)` without an
  explicit style code was silently returning NULL for valid dates like
  `7/17/2022`, due to locale-dependent format guessing. Fixed by
  specifying style code `101` (mm/dd/yyyy) explicitly.
- **NULL-safe join bug** — plain `=` joins between `clean_pc_data` and
  the dimension tables were silently dropping every row with a NULL in
  any joined column, resulting in an empty fact table. Fixed using
  `ISNULL(...) = ISNULL(...)` comparisons across all fact table joins.
- **Invalid `Payment_Method` values** — 46 rows contained plain numbers
  (e.g. `404`, `452`, `842`) instead of a valid payment method (`Cash`,
  `Bank Transfer`, `Finance`). Root cause not conclusively identified;
  these rows are excluded from `DimPaymentMethod` and the fact table,
  and logged to `dbo.DataQuality_InvalidPaymentMethod`.
- **Misaligned B2B/shop customer rows** — a subset of rows in the
  customer columns represent shop-to-shop purchases rather than
  individual customers (e.g. `Customer_Name = 'ABC Computers'`,
  `Customer_Surname` a number, `Customer_Contact_Number` a first name,
  email NULL). Excluded from `DimCustomer`/`FactPCSales` and logged for
  review rather than modelled as individual customers.
- **Impossible date ordering** — 1,272 rows had `Ship_Date` earlier than
  `Purchase_Date`, which is not logically possible. Traced to the same
  underlying source-file inconsistency as the embedded headers (evidence
  of inconsistent column ordering across export batches). Excluded from
  `clean_pc_data` and logged to `dbo.DataQuality_DateOrderConflicts`,
  rather than auto-swapping the two values, since a swap could mask
  further corruption in neighbouring columns.
- **Missing `Ship_Date`** — the large majority of rows have no recorded
  ship date. Not treated as an error to fix; `Purchase_Date` alone is
  required in the fact table, and `Ship_Date` is retained as NULL where
  unknown (see Approach and Why above).

### Open / Unresolved
- Root cause of the 46 numeric `Payment_Method` values was not
  identified — excluded rather than explained.
- Whether missing `Ship_Date` reflects genuine unshipped/untracked
  orders versus further column-order corruption has not been
  conclusively determined. Treated as the former by default, pending
  further investigation (e.g. checking for correlation with `Channel`
  or `Priority`).
- `Credit_Score` distribution is heavily skewed toward the "Poor"
  FICO band (~57% of rows), well outside typical real-world
  distributions. Not corrected, since there's no basis to determine
  which values (if any) are wrong versus simply reflecting how this
  dataset was generated. Flagged as a limitation on any credit-score-based
  analysis.
- `Channel` and `Continent` should be re-verified to confirm the full
  range of values from `clean_pc_data` are actually represented in the
  fact table (i.e. that no dimension/join issue is silently narrowing
  the results), before treating channel- or continent-level analysis as
  final.

## Data Model

`FactPCSales` at the centre, joined to:
- `DimLocation` (Continent, Country_or_State, Province_or_City)
- `DimShop` (Shop_Name, Shop_Age)
- `DimCustomer` (Customer_Name, Customer_Surname, Customer_Contact_Number, Customer_Email_Address)
- `DimProduct` (PC_Make, PC_Model, Storage_Capacity, Storage_Type, RAM)
- `DimSalesPerson` (Sales_Person_Name, Sales_Person_Department)
- `DimChannel` (Channel)
- `DimPriority` (Priority)
- `DimPaymentMethod` (Payment_Method)

Fact grain: one row per unique combination of `Purchase_Date`,
`Ship_Date`, and all dimension keys, enforced structurally where
possible. `vw_PCSalesFlat` joins all of the above back together for
simple, flat analytical querying.

## Analysis Questions Answered

1. Revenue and margin by PC manufacturer
2. Sales distribution by continent
3. Channel comparison (revenue, discounting, financing)
4. Sales person performance by department
5. Priority level vs. average repair cost
6. Credit score band vs. use of financing
7. Monthly sales trend over time

## Pipeline Status

| Metric | Value |
|---|---|
| `clean_pc_data` row count | ~10,000 (post exclusions) |
| `FactPCSales` row count | 1,956 |

The fact row count reflects the cumulative effect of all exclusions
above (bad Payment_Method, B2B customer rows, impossible date ordering)
plus the `Purchase_Date IS NOT NULL` requirement. This is expected and
documented, not an unexplained data loss.

## How to Run

1. Open SQL Server Management Studio (SSMS)
2. Run scripts in order:
   `create_database.sql` → `load_raw_data.sql` → `create_staging_tables.sql`
   → `data_quality_checks.sql` → `create_clean_table.sql`
   → `data_modelling.sql` → `create_view.sql` → `analysis.sql`
3. Update the file path in `load_raw_data.sql` to match your local CSV
   location
4. The raw table is loaded once and guarded against re-loading; to
   reload from a corrected CSV, the table must be explicitly dropped
   first
5. To rebuild after a staging/cleaning fix, re-run from the earliest
   affected script onward — staging is always rebuilt from raw; clean,
   the model, and the view are always rebuilt from staging/clean

## Tools Used

- SQL Server Express
- SQL Server Management Studio (SSMS)
- T-SQL
- Git & GitHub