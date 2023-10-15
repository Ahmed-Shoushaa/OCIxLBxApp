output "vcn_id" {
  value = var.vcn_id == "none" ? tostring(oci_core_vcn.vcn[0].id) : var.vcn_id
}

output "security_list_id" {
  value = oci_core_security_list.security_list[*].id
}

output "internet_gateway_id" {
  value = oci_core_internet_gateway.igw[*].id
}

output "nat_gateway_id" {
  value = oci_core_nat_gateway.nat_gateway[*].id
}

output "service_gateway_id" {
  value = oci_core_service_gateway.service_gateway[*].id
}

output "loggroup_id" {
  value = oci_logging_log_group.vcnloggroup.id
}