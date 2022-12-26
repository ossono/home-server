#!/bin/sh

apt-get update -y
apt-get upgrade -y
apt-get install mc -y
apt-get install \
apparmor \
jq \
wget \
curl \
udisks2 \
libglib2.0-bin \
network-manager \
dbus \
lsb-release \
systemd-journal-remote -y
sh -c "echo 'export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' >> /root/.bashrc"
curl -fsSL get.docker.com | sh
wget https://github.com/home-assistant/os-agent/releases/download/1.4.1/os-agent_1.4.1_linux_x86_64.deb
dpkg -i os-agent_1.4.1_linux_x86_64.deb
wget https://github.com/home-assistant/supervised-installer/releases/latest/download/homeassistant-supervised.deb
dpkg -i homeassistant-supervised.deb
wget -O - https://get.hacs.xyz | bash -
