#!/bin/bash
# configures bastion host to run tiny-proxy
cd "${0%/*}"
. ./common/errors.sh
. ./common/print.sh

PROJECT_ID=${PROJECT_ID:="gitops-argo"}
BASTION_HOST_NAME=${BASTION_HOST_NAME:="cluster-bastion-host"}

gcloud compute ssh $BASTION_HOST_NAME \
	--tunnel-through-iap \
	--project=$PROJECT_ID \
	--command='sudo apt install tinyproxy -y && 
  echo "Allow localhost" | sudo tee -a /etc/tinyproxy/tinyproxy.conf && 
  sudo service tinyproxy restart && 
  echo "tiny proxy configured"'
