resource "oci_load_balancer" "lb" {
  #Required
  compartment_id = var.compartment_id
  display_name   = var.label_prefix == "none" ? var.lb_display_name : "${var.label_prefix}-${var.lb_display_name}"
  shape          = "flexible"
  subnet_ids     = [var.lb_subnet_ids]
  is_private     = var.lb_is_private
  dynamic "reserved_ips" {
    for_each = var.lb_is_private == true ? [] : [1]
    content {
      id = var.reserved_ip_id == false ? null : var.reserved_ip_id
    }
  }
  shape_details {
    maximum_bandwidth_in_mbps = var.lb_maximum_bandwidth_in_mbps
    minimum_bandwidth_in_mbps = var.lb_minimum_bandwidth_in_mbps
  }
}

resource "oci_load_balancer_backend_set" "backendset" {
  for_each         = var.backend_sets
  name             = each.value.name
  load_balancer_id = oci_load_balancer.lb.id
  policy           = "ROUND_ROBIN"
  health_checker {
    port                = each.value.port
    protocol            = each.value.protocol
    response_body_regex = ".*"
    url_path            = each.value.url_path
  }
}

resource "oci_load_balancer_listener" "lb-listener" {
  load_balancer_id         = oci_load_balancer.lb.id
  for_each                 = var.listeners
  name                     = each.value.name #"listener-app"
  default_backend_set_name = each.value.backend_set_name
  port                     = each.value.listener_port
  protocol                 = each.value.listener_protocol
  /* routing_policy_name      = var.routing_policies.count == 1 ? oci_load_balancer_load_balancer_routing_policy.route_policy[0].name : null */

  depends_on = [oci_load_balancer_backend_set.backendset]
}

resource "oci_load_balancer_backend" "lb-backend" {
  for_each         = var.backends
  load_balancer_id = oci_load_balancer.lb.id
  backendset_name  = each.value.bs_name
  ip_address       = each.value.instance_private_ip
  port             = each.value.port
  backup           = each.value.backup
  drain            = false
  offline          = false
  weight           = 1

  depends_on = [oci_load_balancer_backend_set.backendset]
}

/* resource "oci_load_balancer_load_balancer_routing_policy" "route_policy" {
  condition_language_version = "V1"
  load_balancer_id           = oci_load_balancer.lb.id
  name                       = var.routing_policies.name
  count                      = var.routing_policies.count
  dynamic "rules" {
    for_each = var.routing_policies.rps
    content {
      actions {
        backend_set_name = oci_load_balancer_backend_set.backendset[var.backends.b1_1.bs_name].name
        name             = "FORWARD_TO_BACKENDSET"
      }
      condition = "all(http.request.url.path sw (i '${rules.value.path}'))"
      name      = rules.value.name
    }
  }

} */
