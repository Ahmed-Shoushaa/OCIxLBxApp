#####################
# Provider variables
#####################
variable "tenancy_ocid" {}
variable "region" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "label_prefix" {
  description = "a string that will be prepended to all resources"
  type        = string
  default     = "none"
}

#####################
# Compartments
#####################
variable "compartment_name" {}
variable "compartment_description" {}
/* variable "availability_domain" {} */
variable "imported_compartment_id" {}

#####################
# Network variables (VCN)
#####################
variable "vcn_cidr" {}
variable "vcn_display_name" {
  default = "vcn"
}
variable "vcn_dns" {}
variable "imported_vcn_id" {}
variable "imported_loggroup_id" {}
variable "imported_igw_id" {}
variable "create_internet_gateway" {
  default = false
  type    = bool
}
variable "internet_gateway_display_name" {
  default = "igw"
}

###################
# Subnet
###################
variable "me_label_prefix" {
  description = "a string that will be prepended to all resources"
  type        = string
  default     = "none"
}
variable "app_sn_name" {}
variable "lb_sn_name" {}

variable "app_sn_cidr" {}
variable "lb_sn_cidr" {}

variable "app_dns_label" {}
variable "lb_dns_label" {}

variable "sn_is_public" {
  default = false
  type    = bool
}

##############
#Route tabels
##############
variable "app_route_table_name" {}
variable "lb_route_table_name" {}

################
# Security list
################
variable "app_sl_displayed_name" {}
variable "lb_sl_displayed_name" {}


###################
# instances  
variable "ubunt_20-04" {}
variable "oraclelinux_9" {}
variable "instance_shape" {}

variable "app_memory" {}
variable "app_cpu" {}
variable "app_displayed_name" {}
variable "app_boot_size" {}
variable "app_1_ip" {}
variable "app_1_public_key" {}

#################
# LOAD BALANCER
#################
variable "lb_display_name" {}
variable "lb_is_private" {
  default = true
  type    = bool
}

variable "lb_minimum_bandwidth_in_mbps" {}
variable "lb_maximum_bandwidth_in_mbps" {}
variable "listener_port" {}
variable "listener_protocol" {}





