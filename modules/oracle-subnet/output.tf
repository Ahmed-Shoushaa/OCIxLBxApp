output "subnet_id" {
  value = oci_core_subnet.vcn-subnet.id
}
output "subnet_cidr" {
  value = oci_core_subnet.vcn-subnet.cidr_block
}