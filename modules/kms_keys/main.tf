resource "oci_kms_key" "master_key" {
  compartment_id = var.compartment_id
  display_name   = var.key_display_name
  key_shape {
    algorithm = var.key_shape_algorithm
    length    = var.key_shape_length
  }
  management_endpoint = var.key_management_endpoint
  protection_mode     = var.key_protection_mode
}