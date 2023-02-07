#!/bin/bash

# Example script to delete an IBM Cloud security group rule
sleep 60

terraform destroy -target=ibm_is_security_group_rule.inbound_tcp_port_22 -force

# Check the result of the delete command
if [ $? -eq 0 ]; then
  echo "Successfully deleted security rule ${ibm_is_security_group_rule.inbound_tcp_port_22}"
else
  echo "Failed to delete security rule ${ibm_is_security_group_rule.inbound_tcp_port_22}"
fi
