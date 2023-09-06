# ############################################################################
# COMMON
# ############################################################################
project_id = "gitops-argo"
region     = "europe-west2"
zone       = "europe-west2-a"
gcp_service_list = [
  "autoscaling.googleapis.com",
  "cloudkms.googleapis.com",
  "compute.googleapis.com",
  "container.googleapis.com",
  "dns.googleapis.com",
  "iap.googleapis.com",
  "logging.googleapis.com",
  "monitoring.googleapis.com",
  "networkconnectivity.googleapis.com",
  "oslogin.googleapis.com",
  "serviceusage.googleapis.com",
  "storage-api.googleapis.com"
]

# ############################################################################
# BASTION HOST
# ############################################################################
bastion_host_name         = "cluster-bastion-host"
bastion_host_machine_type = "e2-micro"

# ############################################################################
# IAM
# ############################################################################
iam_crossplane_service_account_name = "cluster-crossplane"
iam_crossplane_service_account_permissions = [
  "roles/container.clusterAdmin",
  "roles/compute.networkAdmin",
]

# ############################################################################
# KMS
# ############################################################################
kms_key_name        = "cluster-keyring"
kms_ring_name       = "crypto-ring-a"
kms_algorithm       = "GOOGLE_SYMMETRIC_ENCRYPTION"
kms_rotation_period = "2592000s" // 30 days

# ############################################################################
# KUBERNETES
# ############################################################################
cluster_name       = "crossplane"
primary_node_count = 1

# ############################################################################
# NETWORKING
# ############################################################################
vpc_name        = "crossplane-vpc"
subnet_name     = "crossplane-subnet"
nat_router_name = "crossplane-nat"
