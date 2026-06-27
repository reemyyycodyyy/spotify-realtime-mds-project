# Real-Time Spotify Analysis Pipeline

This project implements an end-to-end real-time data engineering pipeline designed to ingest, stream, store, transform, and visualize streaming Spotify data. The entire infrastructure is containerized using Docker to ensure seamless orchestration, scalability, and modular deployment.

---

## Architecture Overview

The pipeline handles streaming data through the following decoupled layers:

1. **Data Source & Streaming:** Streaming real-time Spotify API data is ingested continuously into **Apache Kafka** (managed via Zookeeper and monitored using Kafdrop).
2. **Data Storage (Landing Layer):** Kafka consumers land raw JSON/event payloads into an Amazon S3-compatible object storage layer via **MinIO**.
3. **Orchestration:** **Apache Airflow** schedules, monitors, and automates the flow of data across the pipeline layers.
4. **Data Warehouse (Medallion Architecture):** Data is loaded into **Snowflake** and systematically transformed using **dbt (Data Build Tool)** across three schema layers:
   * 🥉 **Raw Layer:** Staging area for unfiltered, freshly landed storage data.
   * 🥈 **Cleaned Layer:** Deduplicated, structured, and validated data models.
   * 🥇 **Business Ready Layer:** Aggregated, analytical data marts optimized for business intelligence reporting.
5. **Visualization:** Downstream business layers consume analytical tables directly into **Power BI** for interactive real-time dashboarding.

---

## Tech Stack

* **Infrastructure:** Docker, Docker Compose
* **Event Streaming:** Apache Kafka, Zookeeper, Kafdrop
* **Data Lake / Storage:** MinIO (S3 Compatible object storage)
* **Orchestration:** Apache Airflow
* **Data Warehouse:** Snowflake
* **Data Transformation:** dbt-core, dbt-snowflake
* **Programming:** Python 3.13, SQL
* **BI Analytics:** Power BI

---

## Directory Structure

```text
spotify-mds-project/
├── docker/
│   └── docker-compose.yaml    # Core services (Kafka, Airflow, MinIO, Postgres)
├── dbt/                       # dbt models for Raw, Cleaned, and Business Ready schemas
├── scripts/                   # Kafka producers and consumers for Spotify API
├── .env                       # Environment variables & pipeline credentials (local only)
├── .gitignore                 # Excluded configurations and sensitive credentials
├── requirements.txt           # Python project dependencies
└── README.md
