#!/bin/bash

set -e

# Delete Debezium Server manifests
kubectl delete -f debezium/debezium-server/ -n debezium

# Delete Debezium Operator manifests
kubectl delete -f debezium/debezium-operator/ -n debezium

# Delete the debezium namespace
kubectl delete namespace debezium
