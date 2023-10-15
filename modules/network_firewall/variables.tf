variable "label_prefix" {}
variable "network_firewall_display_name" {}
variable "subnet_id" {}
variable "compartment_id" {}
variable "network_firewall_ipv4address" {}

variable "network_firewall_policy_display_name" {}

#Application
variable "application_list" {}

#URL

#IP
variable "ip_list" {}

# Security Rule
variable "security_rule" {}

data "oci_identity_availability_domain" "ad" {
  compartment_id = var.compartment_id
  ad_number      = 1
}
