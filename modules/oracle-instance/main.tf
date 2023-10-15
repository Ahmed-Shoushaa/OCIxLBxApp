resource "oci_core_instance" "vm_instance" {
  availability_domain = data.oci_identity_availability_domain.ads.name
  compartment_id      = var.compartment_id
  shape               = var.shape
  display_name        = var.label_prefix == "none" ? var.instance_name : "${var.label_prefix}-${var.instance_name}"
  fault_domain        = var.instance_fault_domain
  source_details {
    source_id               = var.source_id
    source_type             = "image"
    boot_volume_size_in_gbs = var.boot_volume_size_in_gbs
  }

  shape_config {
    memory_in_gbs = var.memory
    ocpus         = var.cpu
  }

  create_vnic_details {
    assign_public_ip = var.is_public
    subnet_id        = var.subnet_id
    private_ip       = var.private_ip
    nsg_ids          = var.nsg_ids_list # list of network security group
    hostname_label   = var.hostname_label
  }
  instance_options {
    are_legacy_imds_endpoints_disabled = true
  }
  agent_config {
    is_management_disabled   = "false"
    is_monitoring_disabled   = "false"
    are_all_plugins_disabled = false
    plugins_config {
      desired_state = "ENABLED"
      name          = "Vulnerability Scanning"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "OS Management Service Agent"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Run Command"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Monitoring"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Block Volume Management"
    }
  }

  is_pv_encryption_in_transit_enabled = true
  /* launch_options {
    network_type                        = "VFIO"
    is_pv_encryption_in_transit_enabled = true
  } */
  metadata = {
    ssh_authorized_keys = var.instance_key
  }
  lifecycle {
    ignore_changes = [metadata]
  }
}


# 
resource "oci_core_volume_backup_policy_assignment" "test_volume_backup_policy_assignment" {
  #Required
  asset_id  = oci_core_instance.vm_instance.boot_volume_id
  policy_id = "ocid1.volumebackuppolicy.oc1..aaaaaaaadrzfwjb5tflixtmy5axp2kx65uqakgnupfogabzjhtn5x5dfra6q"
}