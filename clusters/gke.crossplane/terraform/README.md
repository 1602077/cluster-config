# terraform

terraform modules to provision a private gke cluster on an isolated vpc. This 
cluster runs `crossplane` (managed via `argo`) and this is used to provision 
clusters where actual workloads will run on them.

All workload cluster configuration is therefore defined in `/clusters`.

