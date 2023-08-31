# clusters

Contains either `terraform` or `crossplane` configuration for clusters being 
managed.

As aforementioned a control-plane and worker cluster setup is used. The 
control-plane cluster is managed via terraform as a bootstrap and it controls
the provisioning of all worker clusters (clusters where workloads are run on)
using `crossplane`.
