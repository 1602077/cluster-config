#!/bin/bash
# bootstraps an argo-cd managed cluster.

function exit_trap() { echo -e "\n$0:${BASH_LINENO[0]} '$BASH_COMMAND' failed" >&2; }
function print-header() { echo -e "\033[31m>> $@\033[0m"; }

trap exit_trap ERR
set -eoa pipefail

# ----------------------------------------------------------------------------

GITHUB_REPO=${GITHUB_REPO:="https://github.com/1602077/gitops-argo"}
ARGO_PORT=${ARGO_PORT:="8080"}

cd "${0%/*}/.." # run from root of repo.

print-header "bootstrapping cluster"

kubectl kustomize ./bootstrap/argocd/base/ | kubectl apply -f -

print-header "waiting for argo-cd server to initialise"

kubectl wait po -n argocd \
	$(kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2) \
	--for condition=Ready \
	--timeout=120s

kubectl port-forward svc/argocd-server -n argocd ${ARGO_PORT}:443 >/dev/null &

print-header "logging into argo"
# Should update password in a production scenario to not be the default. Only
# running in dev clusters for testing so security is not an issue.
argocd admin initial-password -n argocd | head -1 | pbcopy
argocd login "localhost:${ARGO_PORT}" --username admin 2>/dev/null

print-header "registering ${GITHUB_REPO} to argo"
argocd repo add ${GITHUB_REPO}

print-header "creating argo components"
kubectl apply -f ./components/main.yaml
kubectl apply -f ./components/gitops-controller/
kubectl apply -f ./components/apps/
