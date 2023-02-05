#!/bin/bash

# Example script to delete an IBM Cloud security group rule
sleep 120
# Get the name of the security rule to be deleted
rule_name="$ibm_is_security_group_rule.inbound_tcp_port_22"

# Delete the security rule using the IBM Cloud CLI
ibmcloud target -r eu-de
ibmcloud is security-group-rule-delete "$rule_name" --force 

# Check the result of the delete command
if [ $? -eq 0 ]; then
  echo "Successfully deleted security rule $rule_name"
else
  echo "Failed to delete security rule $rule_name"
fi
