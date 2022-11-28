#!/bin/bash

BGreen='\u001b[32;1m'
NC='\033[0m'
echo -e "${BGreen}"
read -p "Please enter your DD_API_KEY and press ENTER: " -s API_KEY
#read API_KEY
echo"${NC}"
DD_API_KEY="$API_KEY" DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"

sudo cp ./datadog/datadog.yaml /etc/datadog-agent/

#echo -e "\napi_key: ${API_KEY}" | sudo tee -a /etc/datadog-agent/datadog.yaml
sudo bash -c "echo "api_key:$API_KEY" >> /etc/datadog-agent/"datadog.yaml
sudo service datadog-agent restart
sleep 7
sudo datadog-agent status
