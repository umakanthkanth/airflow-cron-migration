FROM quay.io/astronomer/astro-runtime:10.2.0

# Copy DAGs
COPY dags/ /opt/airflow/dags/

# Copy requirements
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt

