#!/bin/bash
BGreen='\u001b[32;1m'
NC='\033[0m'
echo "Do you want to install Datadog agent?"
bash dd_install.sh
wait
echo -e "${BGreen}Datadog agent installed successfully, moving on...${NC}"
git clone https://github.com/UTXOnly/sudo_user_create.git
cd sudo_user_create
sudo bash init.sh

sudo apt-get update -y && sudo apt-get upgrade -y
public_ip_address="$(curl -Ls ifconfig.me)"
echo -e "${BGreen}\nYour public ip is: ${public_ip_address}${NC}"
sudo apt install ufw -y
sudo allow 22/tcp
sudo allow from $public_ip_address to any port 53 proto udp
sudo ufw enable
echo -e "${BGreen}\nUFW Firewall active, installing pihole"
#unattended-upgrades.service 
curl -sSL https://install.pi-hole.net | bash

