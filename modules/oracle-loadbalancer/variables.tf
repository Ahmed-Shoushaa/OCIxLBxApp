variable "region" {}
variable "label_prefix" {}

##### Network variables (VCN) ######
variable "compartment_id" {}
variable "vcn_id" {}

####### LOAD BALANCER ######
variable "lb_display_name" {}
variable "lb_is_private" {
  default = true
}
variable "reserved_ip_id" {
  default = false
}
variable "lb_subnet_ids" {}

variable "lb_minimum_bandwidth_in_mbps" {}
variable "lb_maximum_bandwidth_in_mbps" {}

######## Listener
/* variable "listener_port" {
  default = 80
}
variable "listener_protocol" {
  default = "HTTP"
} */

variable "listeners" {
  default = []
}

####### Backend set
variable "backend_set_name" {
  default = "backend-set"
}
variable "backend_sets" {
  default = []
}

######## Backend
variable "backends" {}
variable "routing_policies" {}



