#!/bin/bash
# bootstraps an argo-cd managed cluster.
#
# Assumes cluster has already been provisioned: terraform build manifests for
# a GKE cluster are in `/clusters/gke.crossplane/terraform`.
#
# cluster runs crossplane acting as a "control-plane" for provisioning of
# additional clusters on GKE that will run production workloads.
cd "${0%/*}"
. ./common/errors.sh
. ./common/print.sh
. ./common/variables.sh

# ----------------------------------------------------------------------------

cd .. # run from root of repo.
print-header "bootstrapping cluster"

kubectl apply -k ./services/argocd/overlays/default/

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
kubectl apply -f ./main.yaml
