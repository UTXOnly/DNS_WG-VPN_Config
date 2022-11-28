#!/bin/bash
BGreen='\u001b[32;1m'
BRed='\033[1;31m'
NC='\033[0m'
echo -e "${BGreen}Do you want to install Datadog agent?\n(y|n)${NC}"
read DD_ANSWER
if [[ "$DD_ANSWER" == "y" || "$DD_ANSWER" == "yes" ]]; then
    bash ./datadog/dd_install.sh
    wait
    echo -e "${BGreen}Datadog agent installed successfully, moving on...${NC}"
else
    echo -e "${BGreen}Skipping Datadog agent install${NC}"
fi

#git clone https://github.com/UTXOnly/sudo_user_create.git
#cd sudo_user_create
#sudo bash init.sh

sudo apt-get update -y && sudo apt-get upgrade -y
public_ip_address="$(curl -Ls ifconfig.me)"
echo -e "${BGreen}\nYour public ip is: ${BRed}${public_ip_address}${NC}"

echo -e "${BGreen}Do you want to install Pi-hole?\n(y|n)${NC}"
read DD_ANSWER_PI
if [[ "$DD_ANSWER_PI" == "y" || "$DD_ANSWER_PI" == "yes" ]]; then
    echo -e "\nInstalling pihole${NC}"
    #unattended-upgrades.service 
    curl -sSL https://install.pi-hole.net | bash
    wait
else
    echo -e "${BGreen}Skipping Pi-hole install${NC}"
fi


echo -e "${BGreen}\nDo you want to install a Wireguard VPN server on this host? (y|n)\n${NC}"
read WG_answer
if [[ $WG_answer == "y" || $WG_answer == "yes" ]]; then
    cd ~/
    git clone https://github.com/UTXOnly/WireGuard-Install-Config.git
    cd WireGuard-Install-Config
    #bash install_config.sh
    #su $UID
    bash client-side-install2.sh
else
    echo -e "${BGreen}Skipping Wireguard VPN server install${NC}"
fi 

sudo apt install ufw -y
sudo ufw allow 22/tcp
sudo ufw allow from $public_ip_address to any port 53 proto udp
sudo ufw allow 53/udp
sudo ufw allow from $public_ip_address to any port 80
sudo ufw enable