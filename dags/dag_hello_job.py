
from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2025, 1, 1),
    'retries': 0,
}

with DAG(
    dag_id='hello_job_dag',
    default_args=default_args,
    schedule='*/5 * * * *',
    catchup=False
) as dag:

    task = BashOperator(
        task_id='run_hello_job',
        bash_command='python3 /path/to/scripts/hello_job.py'
    )
