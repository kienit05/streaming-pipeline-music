FROM python:3.11-slim-bookworm

# Java is required by Spark; zstd is used to unpack ListenBrainz dumps
RUN apt-get update && apt-get install -y --no-install-recommends \
        openjdk-17-jre-headless curl zstd procps \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
WORKDIR /app

# install deps first so Docker caches this layer
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .