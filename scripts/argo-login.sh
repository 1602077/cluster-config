#!/bin/bash
set -eou pipefail

ARGO_PORT=${ARGO_PORT:="8080"}

kubectl port-forward svc/argocd-server -n argocd ${ARGO_PORT}:443 >/dev/null &

ARGO_SERVER=$(
	kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2
)

echo -e ">> connecting to ${ARGO_SERVER} on :${ARGO_PORT}"

# Should update password in a production scenario to not default . Only
# running in dev clusters for testing so security is not an issue.
argocd admin initial-password -n argocd | head -1 | pbcopy
argocd login "localhost:${ARGO_PORT}" --username admin

echo -e ">> logged into argo server"
