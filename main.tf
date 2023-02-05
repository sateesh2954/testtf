provider "ibm" {
  version = "1.13.0"
  api_key = var.ibmcloud_api_key
}

variable "ibmcloud_api_key" {
  type = string
}

resource "ibm_is_vpc" "vpc" {
  name = "sat-test"
}

resource "ibm_is_security_group" "sg" {
  name        = "my-security-group"
  vpc         = ibm_is_vpc.vpc.id
}

resource "ibm_is_security_group_rule" "sg_rule" {
  security_group = ibm_is_security_group.sg.id
  direction      = "ingress"
  remote         = "0.0.0.0/0"
  protocol       = "tcp"
  port_min       = 22
  port_max       = 22
}
