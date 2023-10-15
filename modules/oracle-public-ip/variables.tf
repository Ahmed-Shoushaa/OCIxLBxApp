## COMPARTMENTS
variable "compartment_id" {}

## Static IP
variable "lifetime" {
  default = "RESERVED"
}
variable "display_name" {}
variable "label_prefix" {}

variable "private_ip" {
  default = null
}