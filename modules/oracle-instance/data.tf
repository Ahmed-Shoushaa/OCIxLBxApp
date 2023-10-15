data "oci_identity_availability_domain" "ads" {
  compartment_id = var.compartment_id
  ad_number      = 1
}