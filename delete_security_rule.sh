#!/bin/bash

# Example script to delete an IBM Cloud security group rule
sleep 60

SECURITY_RULE_ID = terraform state show ibm_is_security_group_rule.inbound_tcp_port_22
echo $SECURITY_RULE_ID

ibmcloud target -r eu-de

ibmcloud is security-group-rule-delete SECURITY_RULE_ID

# Check the result of the delete command
if [ $? -eq 0 ]; then
  echo "Successfully deleted security rule ${ibm_is_security_group_rule.inbound_tcp_port_22}"
else
  echo "Failed to delete security rule ${ibm_is_security_group_rule.inbound_tcp_port_22}"
fi
