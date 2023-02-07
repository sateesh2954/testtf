#!/bin/bash

# Example script to delete an IBM Cloud security group rule
sleep 60

security_rule_id=$ibm_is_security_group_rule.inbound_tcp_port_22.id
echo "Security rule ID: $security_rule_id"

# Authenticate using IBM Cloud CLI
ibmcloud target -r eu-de


# Delete the security rule
ibmcloud is security-group-rule-delete $security_rule_id

# Check the result of the delete command
if [ $? -eq 0 ]; then
  echo "Successfully deleted security rule $security_group_id"
else
  echo "Failed to delete security rule $security_group_id"
fi
