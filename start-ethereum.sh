#!/bin/bash
set -x -v
apt install -y jq
sysctl -w net.ipv4.ip_forward=1

cp prometheus/prometheus.yml.back prometheus/prometheus.yml

docker volume create -d local ethereum
docker volume create -d local grafana
docker volume create -d local prometheus

read -p "Enter name of network interface which we will use to expose services: " iface 
export addr=$(ip a|grep -A1 ${iface}|tail -2|grep ${iface}|awk -F' ' '{print $2}'|cut -d'/' -f1)
echo "      - targets: ['${addr}:6060']" >> prometheus/prometheus.yml
echo $addr > grafana/host_ip_addr

docker-compose up -d
