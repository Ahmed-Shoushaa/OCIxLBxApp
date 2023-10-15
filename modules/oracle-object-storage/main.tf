resource "oci_objectstorage_bucket" "bucket" {
  compartment_id        = var.compartment_id
  name                  = var.label_prefix == "none" ? var.bucket_name : "${var.label_prefix}-${var.bucket_name}"
  namespace             = var.bucket_namespace
  versioning            = var.bucket_versioning #========> Enabled, Disabled. Allowed Update values: Enabled, Suspended.
  object_events_enabled = true
  kms_key_id            = var.vault_key_id
}