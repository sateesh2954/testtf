#!/bin/bash

# Example script to delete an IBM Cloud security group rule
sleep 60

# Authenticate using IBM Cloud CLI
ibmcloud target -r eu-de
echo $SECURITY_GROUP_ID

# Delete the security rule
ibmcloud is security-group-rule-delete $SECURITY_GROUP_ID

# Check the result of the delete command
if [ $? -eq 0 ]; then
  echo "Successfully deleted security rule $security_group_id"
else
  echo "Failed to delete security rule $security_group_id"
fi
