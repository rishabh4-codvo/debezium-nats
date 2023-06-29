#!/bin/bash

set -e

# Create namespaces
kubectl create namespace debezium

# Apply Debezium Operator manifests
kubectl apply -f debezium/debezium-operator/ -n debezium

# Apply Debezium Server manifests
kubectl apply -f debezium/debezium-server/ -n debezium
