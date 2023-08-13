# services

Contains the kubernetes charts, manifests, kustomize objects etc. that will be
deployable. As to which services are deployed and their config, this is
controlled via argo labels, overlays, and cluster config.

A two axis configuration is supported (`clusters` and `environments`) that
makes it easy for any environment to be deployed to any cloud provider.

Helm charts are committed in their inflated state under `./services/charts`
this gives explicit control of dependencies and prevents breaking changes from
being deployed to clusters from up-stream repos. Charts should be updated 
manually on a rolling basis.

Future work required to investigate whether charts can be committed as a `tar`
and still integrate nicely with `kustomize`. An initial read would suggest no.
