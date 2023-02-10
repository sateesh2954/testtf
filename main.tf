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

resource "null_resource" "delete_ingress_security_rule" { # This code executes to refresh the IAM token, so during the execution we would have the latest token updated of IAM cloud so we can destroy the security group rule through API calls
  provisioner "local-exec" {
    environment = {
      REFRESH_TOKEN       = data.ibm_iam_auth_token.token.iam_refresh_token
      API_KEY             = var.ibmcloud_api_key
      REGION              = var.ibm_region
      SECURITY_GROUP      = ibm_is_security_group.sg.id
        SECURITY_GROUP_RULE = ibm_is_security_group_rule.inbound_tcp_port_22.id
    }
    command     = <<EOT
          echo $SECURITY_GROUP
          echo $SECURITY_GROUP_RULE
          echo $REFRESH_TOKEN
          echo $REGION
          echo $API_KEY
          TOKEN=$(
            echo $(
              curl -X POST "https://iam.cloud.ibm.com/identity/token" -H "Content-Type: application/x-www-form-urlencoded" -d "grant_type=refresh_token&refresh_token=$REFRESH_TOKEN" -u bx:bx
              ) | jq  -r .access_token
          )
          curl -X DELETE "https://$REGION.iaas.cloud.ibm.com/v1/security_groups/$SECURITY_GROUP/rules/$SECURITY_GROUP_RULE" -H "Authorization: Bearer $API_KEY"
        EOT
  }
  depends_on = [
    ibm_is_security_group_rule.inbound_tcp_port_22
  ]
}


