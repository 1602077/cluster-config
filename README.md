# cluster-config

Bootstrapping workflow for a delineated kubernetes multi-cluster architecture
with a control-plane ("master") and worker clusters.

Control-plane cluster is managed and deployed via terraform and is responsible 
for the provisioning of all "worker" clusters (via `crossplane`).

"worker" clusters are where production workloads would be run, currently there
are just basic infrastructure services (`istio`, `prometheus` etc) as this has
allow me to get familiar to the git-ops style workflow.

The provisioning of all applications and application sets is managed using
`argo-cd`, which allows for the provisioning of clusters to be explicitly
versioned controlled and deployed in a git-ops style workflow, as introduced
to me in [A Multi-Cluster, Multi-Cloud Infrastructure with GitOps at CERN - Ricardo Rocha, CERN](https://www.youtube.com/watch?v=h6xDWc6fXao).


# References
* `https://gitlab.cern.ch/clange/gitops-argo-cd`
* `https://developers.redhat.com/articles/2022/09/07/how-set-your-gitops-directory-structure#structuring_your_git_repositories`
* `https://github.com/gnunn-gitops/standards/blob/master/folders.md`

TODO
https://medium.com/google-cloud/gcp-how-to-deploy-cloud-nat-with-terraform-44745a4daaa8
