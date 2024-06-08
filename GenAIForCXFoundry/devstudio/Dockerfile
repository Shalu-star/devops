# Use the official lightweight Python image.   
# https://hub.docker.com/_/python
FROM python:3.10.6-slim

# Allow statements and log messages to immediately appear in the Cloud Run logs
ENV PYTHONUNBUFFERED 1

# Create and change to the app directory.
WORKDIR /usr/src/app

# RUN apt-get update

# RUN apt-get install -y unixodbc
RUN apt-get update \
 && apt-get install --yes --no-install-recommends \
        apt-transport-https \
        curl \
        gnupg \
        unixodbc \
 && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
 && curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list \
 && apt-get update \
 && ACCEPT_EULA=Y apt-get install --yes --no-install-recommends msodbcsql18 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/*
RUN apt update -y 
RUN apt install -y git

# Copy application dependency manifests to the container image.
# Copying this separately prevents re-running pip install on every code change.
COPY devstudio/requirements.txt ./

# Install dependencies.
RUN pip install -r requirements.txt

# Copy local code to the container image.
COPY devstudio/ ./

# Run the web service on container startup.
# Use gunicorn webserver with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
# Timeout is set to 0 to disable the timeouts of the workers to allow Cloud Run to handle instance scaling.
CMD exec uvicorn --host 0.0.0.0 --port $PORT --workers 1 --proxy-headers app:app
