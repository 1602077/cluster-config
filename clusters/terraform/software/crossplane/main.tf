/*
    Contains the base setup of kubernetes secrets to run crossplane.
    The actual deployment of crossplane is handled via argo.
    
    This kind of approach using terraform to provision k8s resources is somewhat
    overkill, however it makes it super easy for me to tear down and spin back up 
    clusters without having to go through annoying manual steps and using k8s in 
    terraform is not something I have the opportunity to do at work.
*/
resource "kubernetes_namespace" "crossplane_system" {
  metadata {
    name = "crossplane-system"
  }
}

resource "kubernetes_secret" "gcp_provider" {
  metadata {
    name      = "gcp-secret"
    namespace = "crossplane-system"
  }

  data = {
    creds = var.crossplane_service_account_key
  }

  type = "Opaque"
}
