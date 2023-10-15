output "network_firewall_private_ip" {
  value = oci_network_firewall_network_firewall.network_firewall.ipv4address
}

output "network_firewall_id" {
  value = oci_network_firewall_network_firewall.network_firewall.id
}

output "network_firewall_ip_id" {
  value = data.oci_core_private_ips.private_ips_by_subnet.private_ips[0].id #oci_core_private_ip.firewall_private_ip.id
}

# resource "oci_core_private_ip" "firewall_private_ip" {
#   ip_address = oci_network_firewall_network_firewall.network_firewall.ipv4address
# }

data "oci_core_private_ips" "private_ips_by_subnet" {
  subnet_id  = var.subnet_id
  ip_address = oci_network_firewall_network_firewall.network_firewall.ipv4address
}