resource "oci_core_public_ip" "public-ip" {
  compartment_id = var.compartment_id
  lifetime       = var.lifetime
  display_name   = var.label_prefix == "none" ? var.display_name : "${var.label_prefix}-${var.display_name}"
  private_ip_id  = var.private_ip
  lifecycle {
    ignore_changes = [private_ip_id]
  }
}
