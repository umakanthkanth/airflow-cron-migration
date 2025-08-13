import os
from pathlib import Path
CRON_FILE = "crontab.txt"   
DAGS_FOLDER = "main/dags"        
Path(DAGS_FOLDER).mkdir(parents=True, exist_ok=True)
with open(CRON_FILE, "r") as f:
    lines = f.readlines()
for line in lines:
    line = line.strip()
    if not line or line.startswith("#"):
        continue

    parts = line.split()
    cron_schedule = " ".join(parts[:5])
    command = " ".join(parts[5:])

    script_name = Path(command.split()[-1]).stem  
    dag_file = f"{DAGS_FOLDER}/dag_{script_name}.py"

    with open(dag_file, "w") as dag:
        dag.write(f"""
from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

default_args = {{
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2025, 1, 1),
    'retries': 0,
}}

with DAG(
    dag_id='{script_name}_dag',
    default_args=default_args,
    schedule_interval='{cron_schedule}',
    catchup=False
) as dag:

    task = BashOperator(
        task_id='run_{script_name}',
        bash_command='{command}'
    )
""")
    print(f"DAG created: {dag_file}")

