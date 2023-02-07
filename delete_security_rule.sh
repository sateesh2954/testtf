#!/bin/bash

# Example script to delete an IBM Cloud security group rule
sleep 60

# Retrieve the security rule ID from the Terraform state file
rule_id=$(terraform output security_group_id)
echo $rule_id
# Use the IBM Cloud CLI to delete the security rule
ibmcloud target -r eu-de

ibmcloud is security-group-rule-delete $rule_id

# Check the result of the delete command
if [ $? -eq 0 ]; then
  echo "Successfully deleted security rule $rule_id"
else
  echo "Failed to delete security rule $rule_id"
fi
