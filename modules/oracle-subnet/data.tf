data "oci_core_services" "all_oci_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"] #or OCI JED  Object Storage
    regex  = true
  }
}