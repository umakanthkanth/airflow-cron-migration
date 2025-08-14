FROM python:3.11-slim

# Install cron
RUN apt-get update && apt-get install -y cron && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Copy all files from repo
COPY . .

# Make script executable
RUN chmod +x scripts/*.py

# Install dependencies (if requirements.txt exists)
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

# Add cron job
RUN crontab /scripts/crontab.txt

# Create log file
RUN touch /var/log/cron.log

# Start cron in foreground
CMD ["cron", "-f"]
