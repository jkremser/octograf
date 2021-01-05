# Octograf
Simple steps to set up Grafana, InfluxDB and Octoprint to show the dashboard w/ a webcam and some stats. Kudos to STEPHEN MCCOMAS for the Grafana dashboard.

# copy public key and ssh to the raspi

```bash
ssh-copy-id pi@octopi.local
ssh pi@octopi.local
```

# install grafana & influxDB

```bash
wget -qO - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list

wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -
echo "deb https://repos.influxdata.com/debian buster stable" | sudo tee /etc/apt/sources.list.d/influxdb.list

sudo apt-get update
sudo apt-get install -y grafana influxdb
```

# create the db

```bash
influx -execute 'CREATE DATABASE octoprint'
```

# allow the systemctl command to be run w/o the password
```bash
cat <<EOF | sudo tee /etc/polkit-1/localauthority/50-local.d/42-manage-units.pkla
[systemd]
Identity=unix-user:pi
Action=org.freedesktop.systemd1.manage-units
ResultAny=yes
ResultInactive=yes
ResultActive=yes
EOF
```

# start both services

```bash
./octograf-start.sh
```

# Continue with
Nice grafana dashboard: https://grafana.com/grafana/dashboards/11204
Octoprint plugin that reports metrics to influxDB: https://github.com/agrif/OctoPrint-InfluxDB

# install the octoprint plugin
Search for the InfluxDB in all available plugins. As for the configuration, the defaults worked for me.

# set up grafana
It should be listening on http://octopi.local:3000/. First create the influxdb datasource, then import the dashboard using its id.

# final tweaks
For the dashboard, change the ip address in the iframe to octopi.local and also allow `GF_PANELS_DISABLE_SANITIZE_HTML=true` in the `/etc/grafana/grafana.ini` (on raspi). The weather widgets also need some tunning, but I am not using them.

# stop the services
When not printing or not looking

```bash
./octograf-stop.sh
```