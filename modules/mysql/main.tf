data "oci_identity_availability_domains" "ads" {
  count          = var.create_mysql_database == true ? 1 : 0
  compartment_id = var.compartment_id
}

resource "oci_mysql_mysql_db_system" "mysql_db_system" {
  count               = var.create_mysql_database == true ? 1 : 0
  availability_domain = data.oci_identity_availability_domains.ads[0].availability_domains[0].name
  compartment_id      = var.compartment_id
  shape_name          = var.mysql_shape_name
  subnet_id           = var.subnet_id
  display_name        = var.mysql_display_name
  description         = var.mysql_description

  data_storage_size_in_gb = var.mysql_data_storage_size_in_gb
  mysql_version           = "8.0.31"

  hostname_label      = var.mysql_hostname_label
  ip_address          = var.mysql_db_system_ip_address
  is_highly_available = var.mysql_is_highly_available

  admin_password = var.mysql_admin_password
  admin_username = var.mysql_admin_username
  port           = var.mysql_port
  #port_x = var.mysql_db_system_port_x
  crash_recovery = var.mysql_db_system_crash_recovery

  deletion_policy {
    is_delete_protected = true
  }
  backup_policy {
    is_enabled        = var.mysql_backup_policy_is_enabled
    retention_in_days = var.mysql_backup_policy_retention_in_days
    window_start_time = var.mysql_backup_policy_window_start_time
  }

  maintenance {
    window_start_time = var.mysql_maintenance_window_start_time
  }
}
