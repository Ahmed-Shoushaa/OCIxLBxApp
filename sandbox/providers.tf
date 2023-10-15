terraform {
  backend "s3" {
    bucket                      = "terraform-bucket"
    key                         = "state/sandbox-terraform.tfstate"
    region                      = "me-jeddah-1"
    endpoint                    = "https://ax2zyztub9nw.compat.objectstorage.me-jeddah-1.oraclecloud.com"
    shared_credentials_file     = "./credentials"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}
