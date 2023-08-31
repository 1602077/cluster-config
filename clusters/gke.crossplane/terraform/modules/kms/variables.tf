variable "region" {
  description = "region that cluster and vpc are located in"
  type        = string
}

variable "kms_key_name" {
  description = "name of the KMS key"
  type        = string
}

variable "kms_ring_name" {
  description = "name of the KMS Keyring"
  type        = string
}

variable "kms_algorithm" {
  description = "algorithm for the KMS key"
  type        = string
}

variable "kms_rotation_period" {
  description = "Time in seconds to rotate key"
  type        = string
}
