#!/bin/bash

# Replace SECURITY_GROUP_NAME with the actual value

ibmcloud target -r eu-de
ibmcloud target -g HPCC
security_group_name="test-sg2"

# Fetch security group ID using IBM Cloud CLI
security_group_id=$(ibmcloud is security-groups --output json | jq --raw-output '.[] | select(.name == "'"$security_group_name"'") | .id')

echo "SG ID is $security_group_id"

# Fetch security rule ID using IBM Cloud CLI
security_rule_id=$(ibmcloud is security-group-rules $security_group_name --vpc sat-test | awk 'NR==4{print $1}')

echo "SG rule ID is $security_rule_id"

# Delete security rule using IBM Cloud CLI
ibmcloud is security-group-rule-delete $security_group_name --vpc sat-test $security_rule_id 

if [ $? -eq 0 ]; then
  echo "Security rule successfully deleted"
else
  echo "Error deleting security rule"
fi
