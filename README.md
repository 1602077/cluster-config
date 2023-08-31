# gitops-argo

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


# directory structure
```bash
├── bootstrap
├── components
├── clusters
└── services
```

* bootstrap: contains the resources required in setting up a cluster pre-argo
installation. This typically will install argo-cd and hereby will contain argo
helm chart, RBAC roles and service accounts etc. Sometimes these steps will be
done manually and then get argo to manage argo.

* clusters: contains the configuration for each cluster as defined in `argo`.
This allows for control of what gets deployed to each cluster (i.e.
`/cluster/gke.prod` can be set up to apply production `kustomize` overlays.

* components / apps: contains the `argo` applications and application set
definitions.

* services: contains the deployable kubernetes objects i.e. kustomize manifests,
helm charts etc. In some cases a distinction is made between an app (i.e. your
web-app) and a service (i.e. prometheus), although this is somewhat artificial
and more of a matter of personal taste.

# References
* `https://gitlab.cern.ch/clange/gitops-argo-cd`
* `https://developers.redhat.com/articles/2022/09/07/how-set-your-gitops-directory-structure#structuring_your_git_repositories`
* `https://github.com/gnunn-gitops/standards/blob/master/folders.md`
