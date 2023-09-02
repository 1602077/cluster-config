#!/bin/bash
# configures bastion host to run tiny-proxy
cd "${0%/*}"
. ./common/errors.sh
. ./common/print.sh
. ./common/variables.sh

gcloud compute ssh $BASTION_HOST \
	--tunnel-through-iap \
	--project=$PROJECT_ID \
	--command='sudo apt install tinyproxy -y && 
  echo "Allow localhost" | sudo tee -a /etc/tinyproxy/tinyproxy.conf && 
  sudo service tinyproxy restart && 
  echo "tiny proxy configured"'
