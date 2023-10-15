##### Network variables (VCN) ######
variable "compartment_id" {}
variable "vcn_id" {}

####### MYSQL DATABASE SERVICE ######
variable "create_mysql_database" {}
variable "mysql_shape_name" {}
variable "subnet_id" {}
variable "mysql_admin_password" {}
variable "mysql_admin_username" {}
variable "mysql_backup_policy_is_enabled" {}
variable "mysql_backup_policy_retention_in_days" {}
variable "mysql_backup_policy_window_start_time" {}
variable "mysql_db_system_crash_recovery" {}
variable "mysql_db_system_ip_address" {}
variable "mysql_data_storage_size_in_gb" {}
#variable "mysql_deletion_policy_automatic_backup_retention" {}
variable "mysql_description" {}
variable "mysql_display_name" {}
variable "mysql_hostname_label" {}
variable "mysql_is_highly_available" {}
variable "mysql_maintenance_window_start_time" {}
variable "mysql_port" {}

