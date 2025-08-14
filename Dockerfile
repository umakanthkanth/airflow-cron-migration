FROM quay.io/astronomer/astro-runtime:13.1.0

COPY dags/ /opt/airflow/dags/
COPY requirements.txt /requirements.txt

