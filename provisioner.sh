#!/bin/bash

compose_filepath=$1

sysctl -w vm.max_map_count=262144
curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > "/dev/null"
apt update && apt upgrade -y
apt install docker-ce docker-compose openjdk-11-jdk -y
usermod -aG docker vagrant
docker-compose -f $compose_filepath up -d