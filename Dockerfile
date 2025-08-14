FROM quay.io/astronomer/astro-runtime:3.0-7

# Optional: install OS packages if needed
# COPY packages.txt .
# RUN if [[ -s packages.txt ]]; then apt-get update && cat packages.txt | xargs apt-get install -y --no-install-recommends && apt-get clean && rm -rf /var/lib/apt/lists/*; fi

# Copy DAGs
COPY dags/ /opt/airflow/dags/

# Copy requirements
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt
