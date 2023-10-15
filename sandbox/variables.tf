#####################
# Provider variables
#####################
variable "tenancy_ocid" {}
variable "region" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "label_prefix" {
  description = "a string that will be prepended to all resources"
  type        = string
  default     = "none"
}

#####################
# Compartments
#####################
variable "compartment_name" {}
variable "compartment_description" {}
variable "availability_domain" {}

#####################
# Network variables (VCN)
#####################
variable "vcn_cidr" {}
variable "vcn_display_name" {
  default = "vcn"
}
variable "vcn_dns" {}

#####################
# Service Gateway
#####################
variable "create_service_gateway" {
  default = false
  type    = bool
}

variable "service_gateway_display_name" {
  default = "svc-gw"
}

#####################
# Internet Gateway
#####################
variable "create_internet_gateway" {
  default = false
  type    = bool
}
variable "internet_gateway_display_name" {
  default = "igw"
}
variable "internet_gateway_route_rules" {
  description = "List of routing rules to add to Internet Gateway Route Table"
  type        = list(map(string))
  default     = null
}

###############
# NAT
###############
variable "create_nat_gateway" {
  default = false
  type    = bool
}
variable "nat_gateway_display_name" {
  default = "nat"
}
variable "nat_gateway_public_ip_id" {
  description = "OCID of reserved IP address for NAT gateway. The reserved public IP address needs to be manually created."
  default     = "none"
  type        = string
}

variable "nat_gateway_route_rules" {
  description = "list of routing rules to add to NAT Gateway Route Table"
  type        = list(map(string))
  default     = null
}

###################
# Subnet
###################
variable "app_sn_name" {}
variable "lb_sn_name" {}
variable "db_sn_name" {}

variable "app_sn_cidr" {}
variable "lb_sn_cidr" {}
variable "db_sn_cidr" {}

variable "app_dns_label" {}
variable "lb_dns_label" {}
variable "db_dns_label" {}

################
# Security list
################
variable "app_sl_displayed_name" {}
variable "lb_sl_displayed_name" {}
variable "db_sl_displayed_name" {}

##############
#Route tabels
##############
variable "app_route_table_name" {}
variable "lb_route_table_name" {}
variable "db_route_table_name" {}

#################
# LOAD BALANCER
#################
variable "lb_display_name" {}

variable "lb_minimum_bandwidth_in_mbps" {}
variable "lb_maximum_bandwidth_in_mbps" {}

#################
# WAF Firewall
#################
variable "waf_policy_display_name" {}
variable "waf_web_app_firewall" {}

###################
# instances  
variable "instance_fault_domain_1" {}
variable "instance_fault_domain_2" {}
variable "ubunt_20-04" {}
variable "oraclelinux_9" {}
variable "standard_e4_flex_shape" {}

variable "app_memory" {}
variable "app_cpu" {}
variable "app_displayed_name" {}
variable "app_boot_size" {}
variable "app_1_ip" {}
variable "app_1_public_key" {}

variable "elastic_search_memory" {}
variable "elastic_search_cpu" {}
variable "elastic_search_displayed_name" {}
variable "elastic_search_boot_size" {}
variable "elastic_search_ip" {}
variable "elastic_search_public_key" {}

##############
# MYSQL
##############
variable "create_mysql_database" {
  default = false
  type    = bool
}
variable "mysql_shape_name" {}
variable "mysql_admin_password" {}
variable "mysql_admin_username" {}
variable "mysql_backup_policy_is_enabled" {
  default = false
  type    = bool
}
variable "mysql_backup_policy_retention_in_days" {}
variable "mysql_backup_policy_window_start_time" {}
variable "mysql_data_storage_size_in_gb" {}
variable "mysql_description" {}
variable "mysql_display_name" {}
variable "mysql_hostname_label" {}
variable "mysql_is_highly_available" {
  default = false
  type    = bool
}
variable "mysql_maintenance_window_start_time" {}
variable "mysql_port" {}
variable "mysql_db_system_crash_recovery" {}
variable "mysql_db_system_ip_address" {}
