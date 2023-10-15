# # Firewall VCN info
# data "oci_core_vcns" "hub_vcn" {
#   compartment_id = "ocid1.compartment.oc1..aaaaaaaaeiu5bhdp5pb2isntumv3tfwoxu6xizatf33osfhizncresvgsu2a"
#   display_name   = "fgs-oci-hub-vcn"
# }

# # Firewall subnet info
# data "oci_core_subnets" "private_lb_subnets" {
#   compartment_id = "ocid1.compartment.oc1..aaaaaaaaeiu5bhdp5pb2isntumv3tfwoxu6xizatf33osfhizncresvgsu2a"
#   display_name   = "sn-fgs-gis-spoke-prd-private-lb"
#   vcn_id         = data.oci_core_vcns.hub_vcn.virtual_networks[0].id
# }


# # Read vcn info from management environment 
# data "terraform_remote_state" "fgs-oci-mngt" {
#   backend = "s3"
#   config = {
#     bucket                      = "terraform-bucket"
#     key                         = "state/management-terraform.tfstate"
#     region                      = "me-jeddah-1"
#     endpoint                    = "https://axdhg9hynvvb.compat.objectstorage.me-jeddah-1.oraclecloud.com"
#     shared_credentials_file     = "./credentials"
#     skip_region_validation      = true
#     skip_credentials_validation = true
#     skip_metadata_api_check     = true
#     force_path_style            = true
#   }
# }