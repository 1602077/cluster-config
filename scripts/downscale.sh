#!/bin/bash
# downscales gcp resources to save costs when not working on project.
cd "${0%/*}"
. ./common/errors.sh
. ./common/print.sh
. ./common/variables.sh

print-header "shutting down bastion host"
gcloud compute instances stop $BASTION_HOST

print-header "disabling cluster autoscaler and resizing node pool"
gcloud container clusters update $CLUSTER_CROSSPLANE_NAME \
	--no-enable-autoscaling \
	--node-pool=$CLUSTER_CROSSPLANE_NODE_POOL_NAME \
	--region=$CLUSTER_ZONE

echo "waiting for cluster to finish reconciling"
while ! gcloud container clusters describe crossplane --region=europe-west2-a | grep "status: RUNNING" | tail -1; do
	echo >&2 "cluster unhealthy, waiting..."
	sleep 30
done

yes | gcloud container clusters resize $CLUSTER_CROSSPLANE_NAME \
	--node-pool $CLUSTER_CROSSPLANE_NODE_POOL_NAME \
	--region=$CLUSTER_ZONE \
	--num-nodes 0
