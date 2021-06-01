#!/bin/bash
set -x -v
echo $PWD
addr=$(cat ./host_ip_addr)
curl -X POST -H "Content-Type: application/json" --data '{
    "id": 1,
    "uid": "GJ-4mn6Gz",
    "orgId": 1,
    "name": "Prometheus",
    "type": "prometheus",
    "typeName": "Prometheus",
    "typeLogoUrl": "public/app/plugins/datasource/prometheus/img/prometheus_logo.svg",
    "access": "proxy",
    "url": '"\"http://${addr}:9090\""',
    "password": "",
    "user": "",
    "database": "",
    "basicAuth": false,
    "isDefault": true,
    "jsonData": {
      "httpMethod": "POST"
    },
    "readOnly": false
  }' "http://${addr}:3000/api/datasources" -u admin:admin

cat ./ETA.json | jq '. + {overwrite: true}' | curl -X POST -H "Content-Type: application/json" -s "http://${addr}:3000/api/dashboards/db" -u admin:admin  ${addr}:3000/api/dashboards/db --data @-
