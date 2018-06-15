#!/bin/bash
# From: helm status grafana
set -x
POD_NAME=$(kubectl get pods --namespace monitoring -l "app=grafana" -o jsonpath="{.items[0].metadata.name}")
echo "Visit: http://localhost:3000/"
echo "Run: kubectl --namespace monitoring port-forward $POD_NAME 3000"
pass=$(kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 -d)
echo "       user: admin  password: $pass"

# Add Datasource:
#   Settings:
#     Name: prometheus
#     Type: Prometheus
#   HTTP:
#   URL: http://prometheus-server/
# Add Dashboard:
#   Import: 3119

