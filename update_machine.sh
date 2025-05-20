#!/bin/bash

# Script for updating Vast.ai server

set -e

echo "Stopping Docker and Vast.ai services..."
systemctl stop vastai.service || echo "vastai.service is not running or does not exist."
systemctl stop docker.socket || echo "docker.socket is not running or does not exist."
systemctl stop docker.service || echo "docker.service is not running or does not exist."

sleep 2

# Machine ID (recommended to back up)
echo "Machine ID (please back up this information):"
cat /var/lib/vastai_kaalia/machine_id && printf '\n'

sleep 2

export DEBIAN_FRONTEND=noninteractive

echo "Updating package list..."
apt update

sleep 2

echo "Upgrading packages..."
apt upgrade -y

sleep 2

echo "dissabling automatic upgrades..."
#Remove unattended-upgrades Package so that the dirver don't upgrade when you have clients
sudo apt purge --auto-remove unattended-upgrades -y
sudo systemctl disable apt-daily-upgrade.timer
sudo systemctl mask apt-daily-upgrade.service 
sudo systemctl disable apt-daily.timer
sudo systemctl mask apt-daily.service

sleep 2

echo "Starting Docker and Vast.ai services..."
systemctl start docker.service
systemctl start docker.socket
systemctl start vastai.service

sleep 2

echo "Update completed, machine online!"
