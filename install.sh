#!/bin/bash

echo "Do you want to install Datadog agent?"
bash dd_install.sh
wait

git clone https://github.com/UTXOnly/sudo_user_create.git
cd sudo_user_create
sudo bash init.sh

sudo apt-get update -y && sudo apt-get upgrade -y
public_ip_address="$(curl -Ls ifconfig.me)"
sudo apt install ufw -y
sudo allow 22/tcp
sudo allow from $public_ip_address to any port 53 proto udp
sudo ufw enable
curl -sSL https://install.pi-hole.net | bash

