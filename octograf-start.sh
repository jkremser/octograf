#!/bin/bash
echo "starting.."
ssh pi@octopi.local -- systemctl start influxdb
ssh pi@octopi.local -- systemctl start grafana-server
sleep 3
open http://octopi.local:3000/d/PDZJRXJZz/octoprint?orgId=1&refresh=20s
