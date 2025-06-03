#!/bin/bash

echo "deploying webapp containers..."
docker pull maryokpala/image1:latest1

echo "creating network..."
docker network create acada-apps

for i in {1..6};
do

docker stop acada-webapp$i ; docker rm -f acada-webapp$i || true
docker run -d --name acada-webapp$i --hostname acada-webapp$i --network acada-apps maryokpala/image1:latest1;
done
echo "deploying webapp containers done..."

sleep 20

echo "deploying HAproxy containers..."
docker rm haproxy -f >/dev/null 2>&1 || true
docker run -d --name haproxy --network acada-apps -v /opt/docker_config_files/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro -p 9090:80 haproxy:latest
docker ps | grep -i haproxy*
echo "deploying HAproxy containers done..."
