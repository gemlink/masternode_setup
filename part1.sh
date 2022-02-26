#!/bin/bash

apt-get update
apt-get install wget unzip gpw curl libgomp1 -y

# Creating a swap of 2GB only if it does not exist
# It is considered if it exist a swap it will be bigger than 2GB and we do not modify that

if [ ! -f /swapfile ]; then

	fallocate -l 2G /swapfile
	chmod 600 /swapfile
	mkswap /swapfile
	swapon /swapfile

	sh -c "echo '/swapfile none swap sw 0' >> /etc/fstab"
fi

# Disable services

  systemctl disable --now gemlink.service \
  gemlink.service > /dev/null 2>&1

rm /lib/systemd/system/gemlink.service > /dev/null 2>&1

# Setup /lib/systemd/system/gemlink.service

echo "Creating tent service file..."

echo "[Unit]
Description=GLINK service
After=network.target
[Service]
User=root
Group=root
Type=simple
Restart=always
ExecStart=/root/gemlinkd
WorkingDirectory=/root/.gemlink
TimeoutStopSec=300
[Install]
WantedBy=default.target" > /lib/systemd/system/gemlink.service

echo "
##################################################################
#          Run part2.sh if u are on amd64 processor (VPS)        #
#                                                                #
##################################################################"
