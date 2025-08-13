FROM quay.io/astronomer/astro-runtime:9.1.0
COPY dags/ /usr/local/airflow/dags/
COPY scripts/ /usr/local/airflow/scripts/
