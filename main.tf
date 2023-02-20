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

output "security_group_id" {
  value = ibm_is_security_group_rule.inbound_tcp_port_22.id
}

resource "ibm_is_security_group_rule" "outbound_all" {
  group     = ibm_is_security_group.sg.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}

data "ibm_iam_auth_token" "token" {}

resource "null_resource" "delete_schematics_ingress_security_rule" { # This code executes to refresh the IAM token, so during the execution we would have the latest token updated of IAM cloud so we can destroy the security group rule through API calls
  provisioner "local-exec" {
    environment = {
      REFRESH_TOKEN       = data.ibm_iam_auth_token.token.iam_refresh_token
      REGION              = var.ibm_region
      SECURITY_GROUP      = ibm_is_security_group.sg.id
      SECURITY_GROUP_RULE = ibm_is_security_group_rule.inbound_tcp_port_22.rule_id
    }
    command     = ibmcloud is security-group-rule-delete $SECURITY_GROUP $SECURITY_GROUP_RULE
  }
  depends_on = [
    ibm_is_security_group_rule.inbound_tcp_port_22
  ]
}

