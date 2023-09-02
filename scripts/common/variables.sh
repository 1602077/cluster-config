#!/bin/bash
# shared variables across bash scripts

ARGO_PORT=${ARGO_PORT:="8080"}

BASTION_HOST=${BASTION_HOST:="cluster-bastion-host"}

CLUSTER_CROSSPLANE_NAME=${CLUSTER_CROSSPLANE_NAME:="crossplane"}
CLUSTER_CROSSPLANE_NODE_POOL_NAME=${CLUSTER_CROSSPLANE_NODE_POOL_NAME:="crossplane"}
CLUSTER_HTTPS_PROXY_PORT=${CLUSTER_HTTPS_PROXY_PORT:="8888"}
CLUSTER_ZONE=${CLUSTER_ZONE:="europe-west2-a"}

GITHUB_REPO=${GITHUB_REPO:="https://github.com/1602077/cluster-config"}

PROJECT_ID=${PROJECT_ID:="gitops-argo"}
