#######################
# Security Lists
#######################
resource "oci_core_security_list" "security-list" {
  count          = var.create_new_sl == true ? 1 : 0
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.label_prefix == "none" ? var.security_list_name : "${var.label_prefix}-${var.security_list_name}"
  dynamic "ingress_security_rules" {
    for_each = var.security_lists.rules.ingress
    content {
      stateless   = ingress_security_rules.value.stateless
      source      = ingress_security_rules.value.source
      source_type = ingress_security_rules.value.source_type
      protocol    = ingress_security_rules.value.protocol
      #description = ingress_security_rules.value.description
      dynamic "tcp_options" {
        for_each = ingress_security_rules.value.tcp_options
        content {
          min = tcp_options.value.dst_port_min
          max = tcp_options.value.dst_port_max
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
    stateless        = false
    destination      = "all-jed-services-in-oracle-services-network"
    destination_type = "SERVICE_CIDR_BLOCK"
    protocol         = "all"
  }

}

# ------ Create route table for Subnets
resource "oci_core_route_table" "subnet_route_table" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.label_prefix == "none" ? var.route_table_name : "${var.label_prefix}-${var.route_table_name}"

  dynamic "route_rules" {
    for_each = var.rt_rules
    content {
      description       = route_rules.value.description
      destination       = route_rules.value.destination
      destination_type  = route_rules.value.destination_type
      network_entity_id = route_rules.value.network_entity_id
    }
  }
}

#######################
# Subnets
#######################
resource "oci_core_subnet" "vcn-subnet" {
  compartment_id             = var.compartment_id
  vcn_id                     = var.vcn_id
  cidr_block                 = var.sn_cidr
  display_name               = var.label_prefix == "none" ? var.sn_name : "${var.label_prefix}-${var.sn_name}"
  dns_label                  = var.dns_label
  prohibit_public_ip_on_vnic = var.is_public == true ? false : true
  security_list_ids          = var.create_new_sl == true ? [oci_core_security_list.security-list[0].id] : [var.security_list_id]
}

resource "oci_core_route_table_attachment" "route_table_attachment" {
  subnet_id      = oci_core_subnet.vcn-subnet.id
  route_table_id = oci_core_route_table.subnet_route_table.id
}

#################
# Enable subnet log
#################
resource "oci_logging_log" "vcn_log" {
  display_name = "${var.sn_name}-log"
  log_group_id = var.vcn_loggroup
  log_type     = "SERVICE"
  configuration {
    source {
      category    = "all"
      resource    = oci_core_subnet.vcn-subnet.id
      service     = "flowlogs"
      source_type = "OCISERVICE"
    }
  }
  is_enabled         = true
  retention_duration = 90
}