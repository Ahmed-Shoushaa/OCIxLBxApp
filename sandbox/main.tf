module "AhmedCompartment" {
  source                  = "../modules/oracle-compartments"
  tenancy_ocid            = var.tenancy_ocid
  compartment_description = var.compartment_description
  compartment_name        = var.compartment_name
}