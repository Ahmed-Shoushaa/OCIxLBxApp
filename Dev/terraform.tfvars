# PROVIDER
tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaadptv2dmw6j4hbnvdnkfcd4xv3uevxbawyvb5qymtuuekveowopmq"
user_ocid        = "ocid1.user.oc1..aaaaaaaakltbd3glkjx6ff36cm5my7it3tzkyyxpswy7rlrhlfexujpncclq"
fingerprint      = "d1:3f:9c:aa:cb:c0:c1:ca:a0:74:34:36:bb:52:f2:67"
private_key_path = "C:/Users/Wind-IS/Desktop/OCIxLB/Keys/RSA.pem"
region           = "me-jeddah-1"

# COMPARTMENT
imported_compartment_id = "ocid1.compartment.oc1..aaaaaaaaicpfwfxkd3s4h2rg2zpy3bfrdx36b3auf27f5wkpobwaffkxxvha"
compartment_name        = "MyCompartment"
compartment_description = "My first compartment"

# VCN
imported_vcn_id      = "ocid1.vcn.oc1.me-jeddah-1.amaaaaaa2bix7zaauvbiuy7r7b2euxryfzsp424u46dzo6x4umwzhqmvphzq"
imported_loggroup_id = "ocid1.loggroup.oc1.me-jeddah-1.amaaaaaa2bix7zaaupqr62p6e3pphyezskarpobevyafrnjfttwmuiurfqoa"
imported_igw_id      = "ocid1.internetgateway.oc1.me-jeddah-1.aaaaaaaauovt7sbwaac5fkmjdpl2xydbjrpy252awwc4vgo4cpisdery6awq"
vcn_cidr             = "10.0.0.0/16"
vcn_display_name     = "myvCN"
vcn_dns              = "mydns"
label_prefix         = "Wind-IS"
# IGW
create_internet_gateway       = true
internet_gateway_display_name = "myigw"

# SUBNET
me_label_prefix     = "Ahmed"
lb_sn_name          = "lb-sn"
lb_sn_cidr          = "10.0.3.0/24"
sn_is_public        = true
lb_dns_label        = "lbsndns"
lb_route_table_name = "lb-sn-rt"

lb_sl_displayed_name = "lb-sn-sl"

app_sn_name          = "app-sn"
app_sn_cidr          = "10.0.4.0/24"
app_dns_label        = "appsndns"
app_route_table_name = "app-sn-rt"

app_sl_displayed_name = "app-sn-sl"


ubunt_20-04        = "ocid1.image.oc1.me-jeddah-1.aaaaaaaasa3b3x3lhmmw4lj6yoog2o476spbqfbhsh64supoutav4hswt5sq"
oraclelinux_9      = ""
instance_shape     = "VM.Standard.E2.1.Micro"
app_memory         = 1
app_cpu            = 1
app_displayed_name = "app"
app_boot_size      = 50
app_1_ip           = ""
app_1_public_key   = ""

lb_display_name              = "lb"
lb_is_private                = false
lb_maximum_bandwidth_in_mbps = 1500
lb_minimum_bandwidth_in_mbps = 150

listener_port                = 22
listener_protocol            = "TCP"
