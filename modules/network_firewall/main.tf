resource "oci_network_firewall_network_firewall" "network_firewall" {
  #Required
  compartment_id             = var.compartment_id
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  subnet_id                  = var.subnet_id
  availability_domain        = data.oci_identity_availability_domain.ad.name
  display_name               = var.label_prefix == "none" ? var.network_firewall_display_name : "${var.label_prefix}-${var.network_firewall_display_name}"
  ipv4address                = var.network_firewall_ipv4address
}

resource "oci_network_firewall_network_firewall_policy" "network_firewall_policy" {
  compartment_id = var.compartment_id
  display_name   = var.network_firewall_policy_display_name
  dynamic "application_lists" {
    for_each = var.application_list
    content {
      application_list_name = application_lists.value.name
      dynamic "application_values" {
        for_each = application_lists.value.application_list_value
        content {
          type         = application_values.value.type
          minimum_port = application_values.value.minimum_port
          maximum_port = application_values.value.maximum_port
          icmp_code    = application_values.value.icmp_code
          icmp_type    = application_values.value.icmp_type
        }
      }
    }
  }
  # url_lists {
  #   url_list_name                  = var.network_firewall_policy_url_lists_key #==>name
  #   url_list_values {
  #         type = "SIMPLE"
  #         pattern = var.network_firewall_policy_url_lists_pattern
  #       }
  # }
  dynamic "ip_address_lists" {
    for_each = var.ip_list
    content {
      ip_address_list_name  = ip_address_lists.value.name
      ip_address_list_value = ip_address_lists.value.ip
    }
  }

  dynamic "security_rules" {
    for_each = var.security_rule
    content {
      action = security_rules.value.action #ALLOW - DROP - REJECT- INSPECT
      name   = security_rules.value.name
      condition {
        applications = security_rules.value.applications
        destinations = security_rules.value.destinations
        sources      = security_rules.value.sources
        urls         = security_rules.value.urls
      }
      inspection = security_rules.value.inspection_type #INTRUSION_PREVENTION
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

