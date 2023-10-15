variable "label_prefix" {
  default = "none"
}
variable "compartment_id" {}
variable "instance_fault_domain" {
  default = null
}

variable "hostname_label" {
  default = null
}
variable "shape" {}
variable "source_id" {}
variable "subnet_id" {}
variable "boot_volume_size_in_gbs" {}
variable "memory" {}
variable "cpu" {}
variable "instance_name" {}

variable "is_public" {
  default = false
}
variable "private_ip" {}
variable "nsg_ids_list" {
  default = []
}

variable "instance_key" {
  default = null
}

