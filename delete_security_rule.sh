#!/bin/bash

# Example script to delete an IBM Cloud security group rule
sleep 60

# Authenticate using IBM Cloud CLI
ibmcloud target -r eu-de
security_rule_id=$(terraform output security_rule_id)
echo "Security rule ID: $security_rule_id"

# Delete the security rule
ibmcloud is security-group-rule-delete $security_rule_id

# Check the result of the delete command
if [ $? -eq 0 ]; then
  echo "Successfully deleted security rule $security_group_id"
else
  echo "Failed to delete security rule $security_group_id"
fi
