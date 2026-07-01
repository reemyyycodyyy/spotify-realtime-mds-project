import os
from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator

# Path inside the container where dbt project is mounted
DBT_PROJECT_DIR = "/opt/airflow/dbt_transformation"

default_args = {
    "owner": "airflow",
    "start_date": datetime(2025, 10, 21),
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

with DAG(
    "spotify_minio_to_duckdb_pipeline",
    default_args=default_args,
    description="Trigger dbt to parse raw Spotify data from MinIO into DuckDB",
    schedule_interval="@hourly",
    catchup=False,
) as dag:

    # Automatically installs dbt-duckdb inside the container task workspace right before running
    dbt_run_task = BashOperator(
        task_id="dbt_run_transformations",
        bash_command="pip install dbt-duckdb --quiet && cd /opt/airflow/dbt_transformation && dbt run --profiles-dir ."
    )