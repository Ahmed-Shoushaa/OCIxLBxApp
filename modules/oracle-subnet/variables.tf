variable "vcn_id" {}
variable "compartment_id" {}
variable "label_prefix" {}

#SL
variable "security_lists" {
  default = []
}
variable "security_list_id" {
  default = null
}
variable "security_list_name" {
  default = ""
}
variable "create_new_sl" {
  default = false
}

#subnet
variable "sn_name" {}
variable "sn_cidr" {}
variable "is_public" {
  default = false
}
variable "dns_label" {}

##############
# Route table
##############
variable "rt_rules" {}
variable "route_table_name" {}

############
# Logs
############
variable "vcn_loggroup" {
  default = "none"
}