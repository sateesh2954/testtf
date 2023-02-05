data "ibm_is_vpc" "vpc" {
  name = var.vpc_name
}

data "ibm_resource_group" "rg" {
  name = var.resource_group
}

resource "ibm_is_security_group" "sg" {
  name           = "test-sg2"
  vpc            = data.ibm_is_vpc.vpc.id
  resource_group = data.ibm_resource_group.rg.id
}

resource "ibm_is_security_group_rule" "inbound_tcp_port_22" {
  group     = ibm_is_security_group.sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"

  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group_rule" "outbound_all" {
  group     = ibm_is_security_group.sg.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}

resource "null_resource" "delete_security_rule" {
    provisioner "local-exec" {
        command = "./delete_security_rule.sh ${ibm_is_security_group_rule.inbound_tcp_port_22}"
    }
    triggers = {
    security_rule_name = ibm_is_security_group_rule.inbound_tcp_port_22
  }
}


