# Use official Python image
FROM python:3.10

# Set the working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    build-essential \
    python3-dev \
    libssl-dev

# Copy project files
COPY . /app/

# Create a virtual environment and activate it
RUN python -m venv /opt/venv
RUN . /opt/venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt

# Ensure Gunicorn is installed
RUN . /opt/venv/bin/activate && pip install gunicorn

# Expose the port
EXPOSE 8000

# Start Gunicorn server
CMD ["/opt/venv/bin/gunicorn", "--workers", "3", "--bind", "0.0.0.0:8000", "devpro.wsgi:application"]
