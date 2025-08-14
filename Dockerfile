FROM python:3.11-slim

# Install cron and git
RUN apt-get update && apt-get install -y cron git && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Clone your repo directly
RUN git clone https://github.com/umakanthkanth/airflow-cron-migration.git .

# Make your Python scripts executable
RUN chmod +x main/scripts/*.py

# Install Python dependencies if requirements.txt exists
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

# Create crontab file
RUN echo "*/5 * * * * /usr/local/bin/python3 /workspace/main/scripts/hello_job.py >> /var/log/cron.log 2>&1" > crontab.txt

# Register crontab
RUN crontab crontab.txt

# Create log file
RUN touch /var/log/cron.log

# Run cron in foreground
CMD ["cron", "-f"]
