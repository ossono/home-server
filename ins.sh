#!/bin/sh
chmod -R a+rwx /root
apt-get update
apt-get upgrade
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
touch /home/ossono/docker/docker-compose.yml
apt-get install -y apparmor-utils apt-transport-https avahi-daemon ca-certificates curl dbus jq network-manager socat software-properties-common
systemctl disable ModemManager 
apt-get purge modemmanager -y
curl -sL https://raw.githubusercontent.com/home-assistant/supervised-installer/master/installer.sh |  bash -s -- -m intel-nuc -d /home/ossono/docker/hassio
chmod -R a+rwx /home/ossono
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
