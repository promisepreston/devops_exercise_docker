#!/bin/sh

set -e

GREEN='\033[0;32m'

# Define Variables
ARCA_MYSQL_ROOT_PASSWORD=Password@123

# Create docker network
echo "${GREEN}Creating arcapayments docker network"
docker network inspect arcapayments >/dev/null 2>&1 || \
docker network create arcapayments

# Create a data directory for the MySQL server on the host machine for data persistence
echo "${GREEN}Creating MySQL data directory on the host"
mkdir -p /var/lib/mysql

# Provision kibana
echo "${GREEN}Pulling kibana docker image"
# Pull kibana image from dockerhub
docker pull kibana:6.4.2
echo "${GREEN}Starting docker container for kibana"
# Remove kibana container if it already exists
docker rm -f kibana || true
docker run --name kibana --network arcapayments -p 5601:5601 -d kibana:6.4.2

# Provision Nginx
echo "${GREEN}Pulling nginx docker image"
# Pull nginx image from dockerhub
docker pull nginx:1.21.3
echo "${GREEN}Starting docker container for nginx"
# Remove nginx container if it already exists
docker rm -f nginx || true
docker run --name nginx --network arcapayments -p 8082:8082 -d nginx:1.21.3

# Provision MySQL server
echo "${GREEN}Pulling mysql docker image"
# Pull mysql image from dockerhub
docker pull mysql:8.0.26
echo "${GREEN}Starting docker container for mysql"
# Remove mysql container if it already exists
docker rm -f mysql || true
docker run --name mysql -v /var/lib/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=ARCA_MYSQL_ROOT_PASSWORD --network arcapayments -p 3306:3306 -d mysql:8.0.26
