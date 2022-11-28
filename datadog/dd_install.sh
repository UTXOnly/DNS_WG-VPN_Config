#!/bin/bash

BGreen='\u001b[32;1m'
NC='\033[0m'
echo -e "${BGreen}"
read -p "Please enter your DD_API_KEY and press ENTER: " -s API_KEY
#read API_KEY
echo -e "${NC}"
DD_API_KEY="$API_KEY" DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"
wait
CONFIGS=<< EOF
logs_enabled: true
process_config:
  process_collection:
    enabled: true
EOF
#CONFIGS=$(cat ./datadog/dd_configs)
echo $CONFIGS | sudo tee -a /etc/datadog-agent/datadog.yaml 

#echo -e "\napi_key: ${API_KEY}" | sudo tee -a /etc/datadog-agent/datadog.yaml
echo $CONFIGS | sudo tee -a /etc/datadog-agent/datadog.yaml
sudo service datadog-agent restart
sleep 7
sudo datadog-agent status
