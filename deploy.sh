#!/bin/bash

set -e

echo "Stopping application..."

sudo systemctl stop employee || true

echo "Copying JAR..."

sudo cp target/employee-app-1.0.0.jar /opt/employee-app.jar

echo "Reloading systemd..."

sudo systemctl daemon-reload

echo "Starting application..."

sudo systemctl start employee

sleep 10

echo "Health Check..."

curl http://localhost:8081/

echo

echo "Deployment Successful."