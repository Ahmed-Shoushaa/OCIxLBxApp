resource "oci_identity_compartment" "compartment" {
  compartment_id = var.tenancy_ocid
  description    = var.compartment_description
  name           = var.label_prefix == "none" ? var.compartment_name : "${var.label_prefix}-${var.compartment_name}"
}