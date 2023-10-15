variable "region" {}
variable "label_prefix" {}
variable "compartment_id" {}

##########################
# Network variables (VCN) 
##########################
variable "vcn_cidr" {}
variable "vcn_display_name" {}
variable "vcn_dns" {}

variable "vcn_id" {
  default = "none"
}

#####################
# Internet Gateway
#####################
variable "create_internet_gateway" {
  type    = bool
  default = false
}
variable "internet_gateway_display_name" {
  default = ""
}
# variable "internet_gateway_route_rules" {
#   default = []
# }

#####################
# Service Gateway
#####################
variable "create_service_gateway" {
  type    = bool
  default = false
}
variable "service_gateway_display_name" {
  default = ""
}

#####################
# NAT Gateway
#####################
variable "create_nat_gateway" {
  type    = bool
  default = false
}
variable "nat_gateway_display_name" {
  default = ""
}
variable "nat_gateway_public_ip_id" {
  default = "none"
}
# variable "nat_gateway_route_rules" {
#   default = []
# }
variable "nat_rt" {
  default = null
}

# Security List
variable "security_lists" {
  default = null
}

variable "create_sl" {
  default = false
}