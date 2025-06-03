#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
set -o pipefail  # Consider pipeline failures

echo "📦 Pulling latest web app image..."
docker pull maryokpala/image1:latest1

echo "🌐 Creating Docker network 'acada-apps'..."
docker network create acada-apps 2>/dev/null || echo "Network already exists."

echo "🚀 Deploying webapp containers..."
for i in {1..6}; do
    docker stop acada-webapp$i >/dev/null 2>&1 || true
    docker rm -f acada-webapp$i >/dev/null 2>&1 || true
    docker run -d --name acada-webapp$i --hostname acada-webapp$i --network acada-apps maryokpala/image1:latest1
done
echo "✅ Webapp containers deployed."

echo "⏳ Waiting for containers to stabilize..."
sleep 20

echo "🧭 Deploying HAProxy container..."
docker rm -f haproxy >/dev/null 2>&1 || true
docker run -d --name haproxy --network acada-apps -v /opt/docker_config_files/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro -p 9090:80 haproxy:latest

echo "📋 HAProxy deployment status:"
docker ps | grep -i haproxy || echo "HAProxy container not running."

echo "✅ Deployment completed successfully."
