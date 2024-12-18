FROM frikky/shuffle:app_sdk as builder

# Install system dependencies for MS Office processing
RUN apt-get update && apt-get install -y \
    python3-pip \
    libmagic1 \
    antiword \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

FROM builder as app
COPY src /app

# Shuffler labels
LABEL shuffle_auto_deploy=true
LABEL shuffle_app_version=1.0.0
LABEL shuffle_app_name="CTI - SOAR Email"
LABEL shuffle_app_description="Security-focused email processing and IOC extraction"

ENTRYPOINT ["python", "app.py"] 