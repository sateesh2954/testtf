data "ibm_resource_group" "rg" {
  name = var.resource_group
}

data "ibm_is_region" "region" {
  #name = join("-", slice(split("-", var.zone), 0, 2))
  name = var.region_name
}

data "ibm_is_zone" "zone" {
  name   = var.zone
  region = data.ibm_is_region.region.name
}

data "ibm_is_vpc" "existing_vpc" {
  // Lookup for this VPC resource only if var.vpc_name is not empty
  count = var.vpc_name != "" ? 1:0
  name = var.vpc_name
}

data "ibm_is_vpc" "vpc" {
  name = var.vpc_name
  // Depends on creation of new VPC or look up of existing VPC based on value of var.vpc_name,
  depends_on = [ibm_is_vpc.vpc, data.ibm_is_vpc.existing_vpc]
}

data "template_file" "primary_user_data" {
  template = local.primary_template_file
  vars = {
    vpc_apikey_value     = var.api_key
    region_name          = data.ibm_is_region.region.name
    zone_name            = data.ibm_is_zone.zone.name
    vpc_id               = data.ibm_is_vpc.vpc.id
  }
}

resource "ibm_is_security_group" "login_sg" {
  name           = "test-sat-sg"
  vpc            = data.ibm_is_vpc.vpc.id
  resource_group = data.ibm_resource_group.rg.id
}

resource "ibm_is_security_group_rule" "login_ingress_tcp" {
  group     = ibm_is_security_group.login_sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 22
    port_max = 22
  }
}
