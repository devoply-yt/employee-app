#!/bin/bash
set -e
sudo cp target/employee-app-1.0.0.jar /opt/employee-app.jar
sudo systemctl restart employee
sleep 5
curl -f http://localhost/ || exit 1
echo "Deployment Successful"
