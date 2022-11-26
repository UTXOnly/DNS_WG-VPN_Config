#!/bin/bash

sudo apt-get update && sudo apt-get upgrade
public_ip_address="$(curl -Ls ifconfig.me)"
sudo apt install ufw -y
sudo allow 22/tcp
sudo allow from $public_ip_address to any port 53 proto udp
sudo ufw enable

