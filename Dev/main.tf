import {
  to = module.compartment.oci_identity_compartment.compartment
  id = var.imported_compartment_id
}

module "compartment" {
  source                  = "C:/Users/Wind-IS/Desktop/OCIxLB/modules/oracle-compartments"
  tenancy_ocid            = var.tenancy_ocid
  compartment_description = var.compartment_description
  compartment_name        = var.compartment_name
}

import {
  to = module.vcn.oci_core_vcn.vcn[0]
  id = var.imported_vcn_id
}

import {
  to = module.vcn.oci_logging_log_group.vcnloggroup
  id = var.imported_loggroup_id
}

import {
  to = module.vcn.oci_core_internet_gateway.igw[0]
  id = var.imported_igw_id
}

module "vcn" {
  source                        = "C:/Users/Wind-IS/Desktop/OCIxLB/modules/oracle-network"
  vcn_cidr                      = var.vcn_cidr
  vcn_display_name              = var.vcn_display_name
  vcn_dns                       = var.vcn_dns
  region                        = var.region
  label_prefix                  = var.label_prefix
  compartment_id                = module.compartment.compartment_id
  create_internet_gateway       = var.create_internet_gateway
  internet_gateway_display_name = var.internet_gateway_display_name
}

module "pub-subnet" {
  source         = "C:/Users/Wind-IS/Desktop/OCIxLB/modules/oracle-subnet"
  vcn_id         = module.vcn.vcn_id
  compartment_id = module.compartment.compartment_id
  label_prefix   = var.me_label_prefix
  sn_name        = var.lb_sn_name
  sn_cidr        = var.lb_sn_cidr
  is_public      = var.sn_is_public
  dns_label      = var.lb_dns_label

  rt_rules         = local.public_rt_rules
  route_table_name = var.lb_route_table_name

  create_new_sl      = true
  security_lists     = local.public_sl
  security_list_name = var.lb_sl_displayed_name
  vcn_loggroup       = module.vcn.loggroup_id
}

module "app-subnet" {
  source         = "C:/Users/Wind-IS/Desktop/OCIxLB/modules/oracle-subnet"
  vcn_id         = module.vcn.vcn_id
  compartment_id = module.compartment.compartment_id
  label_prefix   = var.me_label_prefix
  sn_name        = var.app_sn_name
  sn_cidr        = var.app_sn_cidr
  dns_label      = var.app_dns_label

  rt_rules         = local.app_rt_rules
  route_table_name = var.app_route_table_name

  create_new_sl      = true
  security_lists     = local.app_sl
  security_list_name = var.app_sl_displayed_name
  vcn_loggroup       = module.vcn.loggroup_id
}

module "instance" {
  source                  = "C:/Users/Wind-IS/Desktop/OCIxLB/modules/oracle-instance"
  label_prefix            = var.me_label_prefix
  compartment_id          = module.compartment.compartment_id
  shape                   = var.instance_shape
  source_id               = var.ubunt_20-04
  subnet_id               = module.app-subnet.subnet_id
  boot_volume_size_in_gbs = var.app_boot_size
  memory                  = var.app_memory
  cpu                     = var.app_cpu
  instance_name           = var.app_displayed_name
  private_ip              = "10.0.4.10"
  #instance_key            = file("../key1.pub")
}

module "lb" {
  source       = "C:/Users/Wind-IS/Desktop/OCIxLB/modules/oracle-loadbalancer"
  region       = var.region
  label_prefix = var.me_label_prefix

  compartment_id               = module.compartment.compartment_id
  vcn_id                       = module.vcn.vcn_id
  lb_display_name              = var.lb_display_name
  lb_is_private                = var.lb_is_private
  lb_subnet_ids                = module.pub-subnet.subnet_id
  lb_maximum_bandwidth_in_mbps = var.lb_maximum_bandwidth_in_mbps
  lb_minimum_bandwidth_in_mbps = var.lb_minimum_bandwidth_in_mbps

  backend_sets = local.backend_sets

  backends = local.backends

  #listener_port     = var.listener_port
  #listener_protocol = var.listener_protocol

  listeners        = local.listeners
  routing_policies = "" #"local.routing_policies"
}