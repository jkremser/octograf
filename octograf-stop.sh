#!/bin/bash
echo "stopping.."
ssh pi@octopi.local -- systemctl stop influxdb
ssh pi@octopi.local -- systemctl stop grafana-server
