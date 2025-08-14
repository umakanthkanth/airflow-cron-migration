FROM quay.io/astronomer/astro-runtime:3.0-7

# Optional OS packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy DAGs
COPY dags/ /opt/airflow/dags/

# Copy Python dependencies
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt
