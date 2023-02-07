#!/bin/bash

# Example script to delete an IBM Cloud security group rule
sleep 60

# Authenticate using IBM Cloud CLI
ibmcloud login
ibmcloud target -r eu-de

# Get the security rule ID from Terraform state
security_group_id=$(ibmcloud schematics state show $workspace_id | grep ibm_is_security_group_rule.inbound_tcp_port_22.id | awk '{print $3}')

# Delete the security rule
ibmcloud is security-group-rule-delete $security_group_id

# Check the result of the delete command
if [ $? -eq 0 ]; then
  echo "Successfully deleted security rule $security_group_id"
else
  echo "Failed to delete security rule $security_group_id"
fi
