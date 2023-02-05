#!/bin/bash

# Example script to delete an IBM Cloud security group rule

# Get the name of the security rule to be deleted
resource_group_name="ibm_resource_group"
security_rule_name="ibm_is_security_group_rule.inbound_tcp_port_22"

# Delete the security rule using the IBM Cloud CLI
terraform destroy -target=ibm_is_security_group_rule.rule -var "resource_group_name=$resource_group_name" -var "security_rule_name=$security_rule_name"

# Check the result of the delete command
if [ $? -eq 0 ]; then
  echo "Successfully deleted security rule $rule_name"
else
  echo "Failed to delete security rule $rule_name"
fi
