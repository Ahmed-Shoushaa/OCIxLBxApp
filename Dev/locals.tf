locals {
  public_rt_rules = {
    rule1 = {
      network_entity_id = module.vcn.internet_gateway_id[0]
      destination       = "0.0.0.0/0"
      destination_type  = "CIDR_BLOCK"
      description       = "allow internet access"
    }
  }
}

locals {
  public_sl = {
    rules = {
      ingress = {
        rule1 = {
          stateless   = true
          source      = "0.0.0.0/0"
          source_type = "CIDR_BLOCK"
          protocol    = 6
          tcp_options = {
            block1 = {
              dst_port_min = 22
              dst_port_max = 22
            }
          }
          udp_options = {
          }
        }
        rule2 = {
          stateless   = true
          source      = var.vcn_cidr
          source_type = "CIDR_BLOCK"
          protocol    = 6
          tcp_options = {
            block1 = {
              dst_port_min = 80
              dst_port_max = 80
            }
          }
          udp_options = {
          }
        }
      }
    }
  }
}

locals {
  app_rt_rules = {

  }
}

locals {
  app_sl = {
    rules = {
      ingress = {
        rule1 = {
          stateless   = true
          source      = "0.0.0.0/0"
          source_type = "CIDR_BLOCK"
          protocol    = 6
          tcp_options = {
            block1 = {
              dst_port_min = 22
              dst_port_max = 22
            }
          }
          udp_options = {
          }
        }
        rule2 = {
          stateless   = true
          source      = var.vcn_cidr
          source_type = "CIDR_BLOCK"
          protocol    = 6
          tcp_options = {
            block1 = {
              dst_port_min = 80
              dst_port_max = 80
            }
          }
          udp_options = {
          }
        }
      }
    }
  }
}

locals {
  backend_sets = {
    b1 = {
      name     = "app"
      port     = 22
      protocol = "TCP"
      url_path = "/"
    }
  }
}

locals {
  listeners = {
    l1 = {
      name                     = "ssh_listener"
      backend_set_name = local.backend_sets.b1.name
      listener_port                     = 22
      listener_protocol                 = "TCP"
    }
    l2 = {
      name                     = "http_listener"
      backend_set_name = local.backend_sets.b1.name
      listener_port                     = 80
      listener_protocol                 = "TCP"
    }
  }
}

locals {
  backends = {
    b1_1 = {
      bs_name             = "app"
      instance_private_ip = module.instance.instance_private_ip
      port                = 80
      backup              = false
    }
    b1_2 = {
      bs_name             = "app"
      instance_private_ip = module.instance.instance_private_ip
      port                = 80
      backup              = false
    }

    b2_1 = {
      bs_name             = "app_22"
      instance_private_ip = module.instance.instance_private_ip
      port                = 22
      backup              = false
    }
  }
}

/* locals {
  routing_policies = {
    name ="rp"

      path =
      name =  "routingPolicyRule"
  }
} */

