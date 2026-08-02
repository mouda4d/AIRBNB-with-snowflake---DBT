# Airbnb Data Warehouse — Snowflake & dbt

An analytics engineering project modeling Airbnb listings, hosts, and reviews on Snowflake with dbt, using a staging → dimensional → mart layering and Slowly Changing Dimension (Type 2) history tracking.

## What this demonstrates

- **Staging layer** (`models/src/`) — thin, 1:1 models over the raw Snowflake sources (`src_hosts`, `src_listings`, `src_reviews`)
- **Dimensional layer** (`models/dim/`) — cleaned, business-friendly dimensions (`dim_hosts`, `dim_listings`, and a denormalized `dim_hosts_w_listings` join)
- **Fact layer** (`models/fct/`) — `fct_reviews`, materialized **incrementally** — only processes new reviews on each run instead of rebuilding from scratch
- **Mart** (`models/mart/`) — `mart_fullmoon_reviews`, joining review activity against a full-moon-dates seed to explore whether review patterns shift around full moons
- **SCD Type 2 history** (`snapshots/scd_raw_listings.sql`) — a dbt snapshot tracking every historical change to listings over time, including hard-delete detection
- **Source freshness monitoring** (`models/sources.yml`) — the `reviews` source warns if data is over an hour stale, errors past 24 hours

## Stack

Snowflake (cloud data warehouse) · dbt (transformation, testing, documentation) · Airbnb listings/hosts/reviews data

## Project structure
models/
├── src/ # staging models, 1:1 with raw sources
├── dim/ # dimension tables
├── fct/ # incremental fact table
└── mart/ # analysis-ready marts
snapshots/ # SCD Type 2 history
seeds/ # static reference data (full moon dates)


## Running it

1. `pip install dbt-snowflake`
2. Configure `~/.dbt/profiles.yml` with your Snowflake connection ([dbt Snowflake setup docs](https://docs.getdbt.com/docs/core/connect-data-platform/snowflake-setup))
3. `dbt snapshot` — build SCD2 history
4. `dbt run` — build staging → dimensions → facts → marts
5. `dbt test` — run data quality checks

## Notes

Built as a hands-on project to learn dimensional modeling, incremental models, and SCD Type 2 change tracking on a real cloud data warehouse.
