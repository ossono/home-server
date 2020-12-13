#!/bin/sh



chmod -R a+rwx /home
apt-get update -y
apt-get upgrade -y
apt-get install mc -y
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io -y
curl -L https://github.com/docker/compose/releases/download/1.27.0-rc1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
usermod -aG docker ${USER}
touch /etc/environment
sh -c "echo 'PUID=0' >> /etc/environment"
sh -c "echo 'PGID=0' >> /etc/environment"
sh -c "echo 'TZ="Europe/London"' >> /etc/environment"
sh -c "echo 'USERDIR="/home/ossono"' >> /etc/environment"
mkdir /home/ossono/docker
apt-get install acl
setfacl -Rdm g:docker:rwx /home/ossono/docker
chmod -R 775 /home/ossono/docker
#touch /home/ossono/docker/docker-compose.yml
apt-get install -y apparmor-utils apt-transport-https avahi-daemon ca-certificates curl dbus jq network-manager socat software-properties-common
systemctl disable ModemManager 
apt-get purge modemmanager -y
curl -sL https://raw.githubusercontent.com/home-assistant/supervised-installer/master/installer.sh |  bash -s -- -m intel-nuc -d /home/ossono/docker/hassio
chmod -R a+rwx /home/ossono/docker
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
git clone  https://github.com/ossono/HACS.git /home/ossono/docker/hassio/homeassistant/custom_components/hacs
#git clone  https://github.com/ossono/home-server.git /home/ossono/server
sh -c "echo '/dev/sdb /home/ossono/docker/hassio/share/usb' >> /etc/fstab"
rm /etc/netplan/00-installer-config.yaml
touch /etc/netplan/00-installer-config.yaml
sh -c "echo 'network:' >> /etc/netplan/00-installer-config.yaml"
sh -c "echo '  version: 2' >> /etc/netplan/00-installer-config.yaml"
sh -c "echo '  renderer: networkd' >> /etc/netplan/00-installer-config.yaml"
sh -c "echo '  ethernets:' >> /etc/netplan/00-installer-config.yaml"
sh -c "echo '    enp3s0:' >> /etc/netplan/00-installer-config.yaml"
sh -c "echo '     dhcp4: no' >> /etc/netplan/00-installer-config.yaml"
sh -c "echo '     addresses: [192.168.1.65/24]' >> /etc/netplan/00-installer-config.yaml"
sh -c "echo '     gateway4: 192.168.1.1' >> /etc/netplan/00-installer-config.yaml"
sh -c "echo '     nameservers:' >> /etc/netplan/00-installer-config.yaml"
sh -c "echo '       addresses: [8.8.8.8,8.8.4.4]' >> /etc/netplan/00-installer-config.yaml"
netplan apply
chmod -R a+rwx /home/ossono/docker
docker network create znet
sudo reboot

