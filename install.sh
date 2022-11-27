#!/bin/bash
BGreen='\u001b[32;1m'
NC='\033[0m'
echo "Do you want to install Datadog agent?"
bash ./datadog/dd_install.sh
wait
echo -e "${BGreen}Datadog agent installed successfully, moving on...${NC}"
git clone https://github.com/UTXOnly/sudo_user_create.git
cd sudo_user_create
sudo bash init.sh

sudo apt-get update -y && sudo apt-get upgrade -y
public_ip_address="$(curl -Ls ifconfig.me)"
echo -e "${BGreen}\nYour public ip is: ${public_ip_address}${NC}"
sudo apt install ufw -y
sudo ufw allow 22/tcp
sudo ufw allow from $public_ip_address to any port 53 proto udp
sudo ufw enable
echo -e "${BGreen}\nUFW Firewall active, installing pihole"
#unattended-upgrades.service 
curl -sSL https://install.pi-hole.net | bash

echo -e "${BGreen}\nDo you want to install a Wireguard VPN server on this host? (y|n)\n${NC}"
read WG_answer
if [ $WG_answer == "y" ]; then
    cd ~/
    git clone https://github.com/UTXOnly/WireGuard-Install-Config.git
    cd WireGuard-Install-Config
    bash install_config.sh
else
    echo -e "${BGreen}Skipping Wireguard VPN server install${NC}"
fi 
