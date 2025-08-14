FROM quay.io/astronomer/astro-runtime:3.0.4

# Copy DAGs
COPY dags/ /opt/airflow/dags/

# Copy requirements
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt

