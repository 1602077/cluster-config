# apps

Contains resource definitions (`Application`, `ApplicationSet`) for services
that will be managed by `argo`. As standard an "app of apps" pattern is used,
please see `/main.yaml` for more details.


Cluster label selectors and the corresponding components they are responsible
for deploying are detailed below.

- `infra.crossplane: enabled` - `crossplane`
- `infra.istio: enabled` - `istio-base`, `istiod`
- `infra.monitoring: enabled` - `prometheus`, `grafana`, `kubernetes-dashboard`
