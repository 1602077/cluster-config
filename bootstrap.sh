#!/bin/bash
# bootstraps an argo-cd managed cluster.
set -eoa pipefail

GITHUB_REPO=${GITHUB_REPO:="https://github.com/1602077/gitops-argo"}
ARGO_PORT=${ARGO_PORT:="8080"}

kubectl kustomize ./bootstrap/argocd/base/ | kubectl apply -f -

kubectl port-forward svc/argocd-server -n argocd ${ARGO_PORT}:443 >/dev/null &
# Should update password in a production scenario to not default . Only
# running in dev clusters for testing so security is not an issue.
argocd admin initial-password -n argocd | head -1 | pbcopy
argocd login "localhost:${ARGO_PORT}" --username admin

argocd repo add ${GITHUB_REPO}

kubectl apply -f cluster/gitops-controller/application.yaml
