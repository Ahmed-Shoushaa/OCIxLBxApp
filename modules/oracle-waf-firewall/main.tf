resource "oci_waf_web_app_firewall_policy" "waf_web_app_firewall_policy" {
  compartment_id = var.compartment_id
  display_name   = var.label_prefix == "none" ? var.waf_policy_display_name : "${var.label_prefix}-${var.waf_policy_display_name}"

  # actions
  ###########
  actions {
    #Required
    name = "defaultAction"
    type = "ALLOW"
  }

  actions {
    #Required
    name = "return401Response"
    type = "RETURN_HTTP_RESPONSE"
    code = 401
    body {
      #Required
      type = "STATIC_TEXT"
      text = "{\n\"code\": 401,\n\"message\":\"Unauthorised\"\n}"
    }
  }

  actions {
    #Required
    name = "return405ResponseRequestProtection"
    type = "RETURN_HTTP_RESPONSE"
    code = 405
    body {
      #Required
      type = "STATIC_TEXT"
      text = "{\n\"code\": 405,\n\"message\":\"virus\"\n}"
    }
  }
  actions {
    #Required
    name = "return404ResponseReachLimit"
    type = "RETURN_HTTP_RESPONSE"
    code = 404
    body {
      #Required
      type = "STATIC_TEXT"
      text = "{\n\"code\": 404,\n\"message\":\"toManyAccess\"\n}"
    }
  }

  # Request protection: here you can assign new protection rule for waf
  #####################
  request_protection {
    rules {
      #Required
      type        = "PROTECTION"
      name        = "requestProtectionRule"
      action_name = "return405ResponseRequestProtection"
      protection_capabilities {
        collaborative_action_threshold = 0
        key                            = "9420000"
        version                        = 2
      }
      protection_capabilities {
        collaborative_action_threshold = 0
        key                            = "941140"
        version                        = 2
      }
      protection_capabilities {
        collaborative_action_threshold = 0
        key                            = "9410000"
        version                        = 3
      }
      protection_capabilities {
        collaborative_action_threshold = 0
        key                            = "9330000"
        version                        = 2
      }
      protection_capabilities {
        collaborative_action_threshold = 0
        key                            = "9320001"
        version                        = 2
      }
      protection_capabilities {
        collaborative_action_threshold = 0
        key                            = "9320000"
        version                        = 2
      }
      protection_capabilities {
        collaborative_action_threshold = 0
        key                            = "930120"
        version                        = 2
      }
      protection_capabilities {
        collaborative_action_threshold = 0
        key                            = "9300000"
        version                        = 2
      }
      protection_capabilities {
        collaborative_action_threshold = 0
        key                            = "920390"
        version                        = 1
      }
      protection_capabilities {
        collaborative_action_threshold = 0
        key                            = "920380"
        version                        = 1
      }
      protection_capabilities {
        collaborative_action_threshold = 0
        key                            = "920370"
        version                        = 1
      }
      protection_capabilities {
        collaborative_action_threshold = 0
        key                            = "920320"
        version                        = 1
      }
      protection_capabilities {
        collaborative_action_threshold = 0
        key                            = "920300"
        version                        = 1
      }
      protection_capabilities {
        collaborative_action_threshold = 0
        key                            = "911100"
        version                        = 1
      }
    }
  }

  # request_rate_limiting: How many request from the same source are allowed
  request_rate_limiting {
    #Optional
    rules {
      #Required
      type        = "REQUEST_RATE_LIMITING"
      name        = "requestRateLimitingRule"
      action_name = "return404ResponseReachLimit"
      configurations {
        period_in_seconds = 5
        requests_limit    = 200
        #Optional
        action_duration_in_seconds = 10
      }
    }
  }
}

resource "oci_waf_web_app_firewall" "waf_web_app_firewall" {
  compartment_id             = var.compartment_id
  backend_type               = "LOAD_BALANCER"
  load_balancer_id           = var.lb_id
  web_app_firewall_policy_id = oci_waf_web_app_firewall_policy.waf_web_app_firewall_policy.id

  display_name = var.label_prefix == "none" ? var.waf_web_app_firewall_name : "${var.label_prefix}-${var.waf_web_app_firewall_name}"
}
