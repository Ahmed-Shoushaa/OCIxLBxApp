output "instance_private_ip" {
  value = oci_core_instance.vm_instance.private_ip
}
output "instance_public_ip" {
  value = oci_core_instance.vm_instance.public_ip
}
output "instance_id" {
  value = oci_core_instance.vm_instance.id
}
