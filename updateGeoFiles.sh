#!/bin/bash

geoip_file="geoip.dat"
geoip_database="geoip.db"
geosite_file="geosite.dat"
geosite_database="geosite.db"

# check if user is root or sudo, if not then exit with error message
if [[ $EUID -ne 0 ]]; then
    echo "You have to use root or sudo to run this script"
    exit 1
fi

# get geoip.dat and geosite.dat from github
# check if geoip.dat and geosite.dat exist, if not then download them
if [ ! -f "$geoip_database" ]; then
    curl --proxy "http://127.0.0.1:2080" -L -O https://github.com/SagerNet/sing-geoip/releases/latest/download/geoip.db
fi

if [ ! -f "$geoip_file" ]; then
    curl --proxy "http://127.0.0.1:2080" -L -O https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat
fi

if [ ! -f "$geosite_database" ]; then
    curl --proxy "http://127.0.0.1:2080" -L -O https://github.com/SagerNet/sing-geosite/releases/latest/download/geosite.db
fi

if [ ! -f "$geosite_file" ]; then
    curl --proxy "http://127.0.0.1:2080" -L -O https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat
fi

sudo mv geoip.dat /opt/nekoray/geoip.dat
sudo mv geoip.db /opt/nekoray/geoip.db
sudo mv geosite.dat /opt/nekoray/geosite.dat
sudo mv geosite.db /opt/nekoray/geosite.db

# check if update(moved to /opt/nekoray/) successfully,
# if ture then echo "update geoip and geosite success"
# otherwise echo "update geoip and geosite failed"
if [ -f "/opt/nekoray/geoip.dat" ] && [ -f "/opt/nekoray/geoip.db" ] && [ -f "/opt/nekoray/geosite.dat" ] && [ -f "/opt/nekoray/geosite.db" ];then
    echo "update geoip and geosite success"
else
    echo "update geoip and geosite failed"
fi