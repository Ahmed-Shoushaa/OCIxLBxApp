# ########################
# # VCN
# ########################
resource "oci_core_vcn" "vcn" {
  cidr_blocks    = [var.vcn_cidr]
  dns_label      = var.vcn_dns
  compartment_id = var.compartment_id
  display_name   = var.label_prefix == "none" ? var.vcn_display_name : "${var.label_prefix}-${var.vcn_display_name}"
  count          = var.vcn_id == "none" ? 1 : 0
}

########################
# Internet Gateway (IGW)
########################

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_id
  display_name   = var.label_prefix == "none" ? var.internet_gateway_display_name : "${var.label_prefix}-${var.internet_gateway_display_name}"
  vcn_id         = var.vcn_id == "none" ? oci_core_vcn.vcn[0].id : var.vcn_id
  count          = var.create_internet_gateway == true ? 1 : 0
}

#######################
# Service Gateway (SGW)
#######################
resource "oci_core_service_gateway" "service_gateway" {
  compartment_id = var.compartment_id
  display_name   = var.label_prefix == "none" ? var.service_gateway_display_name : "${var.label_prefix}-${var.service_gateway_display_name}"

  services {
    service_id = lookup(data.oci_core_services.all_oci_services[0].services[0], "id")
  }

  vcn_id = var.vcn_id == "none" ? oci_core_vcn.vcn[0].id : var.vcn_id

  count = var.create_service_gateway == true ? 1 : 0
}

###################
# NAT Gateway (NGW)
###################

resource "oci_core_nat_gateway" "nat_gateway" {
  compartment_id = var.compartment_id
  display_name   = var.label_prefix == "none" ? var.nat_gateway_display_name : "${var.label_prefix}-${var.nat_gateway_display_name}"
  public_ip_id   = var.nat_gateway_public_ip_id != "none" ? var.nat_gateway_public_ip_id : null
  vcn_id         = var.vcn_id == "none" ? oci_core_vcn.vcn[0].id : var.vcn_id
  count          = var.create_nat_gateway == true ? 1 : 0
  route_table_id = var.nat_rt
}

#######################
# Security Lists
#######################
resource "oci_core_security_list" "security_list" {
  count          = var.create_sl == true ? 1 : 0
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id == "none" ? oci_core_vcn.vcn[0].id : var.vcn_id
  display_name   = var.label_prefix == "none" ? var.security_lists.name : "${var.label_prefix}-${var.security_lists.rules.name}"
  dynamic "ingress_security_rules" {
    for_each = var.security_lists.rules.ingress
    content {
      stateless   = ingress_security_rules.value.stateless
      source      = ingress_security_rules.value.source
      source_type = ingress_security_rules.value.source_type
      protocol    = ingress_security_rules.value.protocol
      dynamic "tcp_options" {
        for_each = ingress_security_rules.value.tcp_options
        content {
          min = tcp_options.value.from
          max = tcp_options.value.to
        }
      }
      dynamic "udp_options" {
        for_each = ingress_security_rules.value.udp_options
        content {
          min = udp_options.value.from
          max = udp_options.value.to
        }
      }
    }
  }
  egress_security_rules {
    stateless        = false
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
  }
  egress_security_rules {
    destination      = "all-jed-services-in-oracle-services-network"
    destination_type = "SERVICE_CIDR_BLOCK"
    protocol         = "all"
    stateless        = false
  }
}

####################
#VCN loggroup resource
####################
resource "oci_logging_log_group" "vcnloggroup" {
  compartment_id = var.compartment_id
  description    = "${var.vcn_display_name} Log group"
  display_name   = "${var.vcn_display_name}-loggroup"
}