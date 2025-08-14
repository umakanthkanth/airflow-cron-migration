FROM quay.io/astronomer/astro-runtime:3.0-7

COPY dags/ /opt/airflow/dags/
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt
