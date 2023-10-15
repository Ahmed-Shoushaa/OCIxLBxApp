variable "compartment_id" {}
variable "bucket_name" {}
#variable bucket_access_type {}
variable "bucket_namespace" {}
variable "label_prefix" {}
variable "bucket_versioning" {
  default = "Enabled"
}
variable "vault_key_id" {
  default = null
}