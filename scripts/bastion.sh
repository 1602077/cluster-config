#!/bin/bash
# connects to bastion host
cd "${0%/*}"
. ./common/errors.sh
. ./common/print.sh

CROSSPLANE_CLUSTER=${CROSSPLANE_CLUSTER:="crossplane"}
CLUSTER_ZONE=${CLUSTER_ZONE:="europe-west2-a"}
PROJECT=${PROJECT:="gitops-argo"}
BASTION_HOST=${BASTION_HOST:="cluster-bastion-host"}
HTTPS_PROXY_PORT=${HTTPS_PROXY_PORT:="8888"}

print-header "connecting to bastion host"
gcloud container clusters get-credentials \
	$CROSSPLANE_CLUSTER \
	--zone $CLUSTER_ZONE \
	--project $PROJECT

gcloud compute ssh $BASTION_HOST \
	--tunnel-through-iap \
	--project=$PROJECT \
	--zone=$CLUSTER_ZONE \
	--ssh-flag="-4 -L8888:localhost:$HTTPS_PROXY_PORT -N -q -f"

print-header "spawning sub-shell using HTTPS_PROXY"
HTTPS_PROXY="localhost:$HTTPS_PROXY_PORT" \
	PS1='\e[0;36m($(kubectl config current-context))\e[0m $ ' \
	/bin/bash

CLEANUP_CMD="ps aux | grep '[8]888' | awk '{print \$2}' | xargs kill"

echo "$CLEANUP_CMD" | pbcopy

command cat <<EOF

To stop listening on remote client run (added to clipboard):
$CLEANUP_CMD
EOF
