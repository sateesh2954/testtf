#!/bin/bash

# Replace SECURITY_GROUP_NAME with the actual value

ibmcloud target -r eu-de
ibmcloud target -g HPCC
security_group_name="test-sg2"

# Fetch security group ID using IBM Cloud CLI
security_group_id=$(ibmcloud is security-groups --output json | jq --raw-output '.[] | select(.name == "'"$security_group_name"'") | .id')

# Fetch security rule ID using IBM Cloud CLI
security_rule_id=$(ibmcloud is security-group-rules --group-id $security_group_id | awk 'NR==2{print $1}')

# Delete security rule using IBM Cloud CLI
ibmcloud is security-group-rule-delete $security_rule_id -g $security_group_id

if [ $? -eq 0 ]; then
  echo "Security rule successfully deleted"
else
  echo "Error deleting security rule"
fi
