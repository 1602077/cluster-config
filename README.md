# gitops-argo

A first attempt at bootstrapping a cluster using a gitops / argo-cd workflow.

Some useful starting points

* `https://gitlab.cern.ch/clange/gitops-argo-cd`
* `https://developers.redhat.com/articles/2022/09/07/how-set-your-gitops-directory-structure#structuring_your_git_repositories`
* `https://github.com/gnunn-gitops/standards/blob/master/folders.md`

# directory structure
```bash
├── bootstrap
├── cluster
├── component
└── service
```

* bootstrap: contains the resources required in setting up a cluster pre-argo installation. This typically will install argo-cd and hereby will contain argo helm chart, RBAC roles and service accounts etc. Sometimes these steps will be done manually and then get argo to manage argo.

* cluster: contains the configuration for each cluster as defined in `argo`. This allows for control of what gets deployed to each cluster (i.e. `/cluster/gke.prod` can be set up to apply production `kustomize` overlays.

* component / app: contains the `argo` applications and application set definitions.

* service: contains the deployable kubernetes objects i.e. kustomize manifests, helm charts etc. In some cases a distinction is made between an app (i.e. your web-app) and a service (i.e. prometheus), although this is somewhat artificial and more of a matter of personal taste.
