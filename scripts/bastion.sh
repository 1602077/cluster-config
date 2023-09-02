#!/bin/bash
# connects to bastion host
cd "${0%/*}"
. ./common/errors.sh
. ./common/print.sh
. ./common/variables.sh

gcloud compute instances start $BASTION_HOST \
	--zone $CLUSTER_ZONE

print-header "connecting to bastion host"
gcloud container clusters get-credentials \
	$CLUSTER_CROSSPLANE_NAME \
	--zone $CLUSTER_ZONE \
	--project $PROJECT_ID

gcloud compute ssh $BASTION_HOST \
	--tunnel-through-iap \
	--project=$PROJECT_ID \
	--zone=$CLUSTER_ZONE \
	--ssh-flag="-4 -L8888:localhost:$CLUSTER_HTTPS_PROXY_PORT -N -q -f"

print-header "spawning sub-shell using HTTPS_PROXY to connect to $CLUSTER_CROSSPLANE_NAME cluster"
HTTPS_PROXY="localhost:$CLUSTER_HTTPS_PROXY_PORT" \
	PS1='\e[0;36m($(kubectl config current-context))\e[0m $ ' \
	/bin/bash

ps aux | grep '[8]888' | awk '{print $2}' | xargs kill

print-header "disconnected from remote client"
