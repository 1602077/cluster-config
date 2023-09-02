#!/bin/bash
# configures bastion host to run tiny-proxy
function exit() { echo -e "\n$0:${BASH_LINENO[0]} '$BASH_COMMAND' failed" >&2; }
function print-header() { echo -e "\033[31m>> $@\033[0m"; }

trap exit ERR
set -eoa pipefail

PROJECT_ID=${PROJECT_ID:="gitops-argo"}
BASTION_HOST_NAME=${BASTION_HOST_NAME:="cluster-bastion-host"}

gcloud compute ssh $BASTION_HOST_NAME \
	--tunnel-through-iap \
	--project=$PROJECT_ID \
	--command='sudo apt install tinyproxy && 
  echo "Allow localhost" | sudo tee -a /etc/tinyproxy/tinyproxy.conf && 
  sudo service tinyproxy restart && 
  echo "tiny proxy configured"'
