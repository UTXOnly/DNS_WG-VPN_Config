#!/bin/bash

echo "Please enter your DD_API_KEY and press ENTER: "
read API_KEY

DD_API_KEY=${API_KEY} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"

sudo cp ./datadog.yaml /etc/datadog-agent/
echo -e "\napi_key: ${API_KEY}" | sudo tee -a /etc/datadog-agent/datadog.yaml
sudo service datadog-agent restart
