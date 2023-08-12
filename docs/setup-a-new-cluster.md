# Setting up a new cluster

This document outlines the processing for setting up a new cluster from scratch
that is managed by `argo-cd`.

Install `argo-cd` via bootstrap and register as a argo managed component.
```bash
kubectl kustomize ./bootsrap/argocd/base/kustomization.yaml

kubectl port-forward svc/argocd-server -n argocd 8080:443 
argocd admin initial-password -n argocd | head -1 | pbcopy
argocd login "localhost:8080" --username admin

argocd app create argocd \
    --repo https://github.com/1602077/gitops-argo \
    --path bootstrap/argocd \
    --dest-server https://kubernetes.default.svc \
    --dest-namespace argocd

argocd app sync argo-cd
```
