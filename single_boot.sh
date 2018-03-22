#!/bin/bash

sleep 2s

echo -e "\nNova controller is booting POLICY instance.."
echo '-------------------------------'

policy_access_pid=$(neutron port-list | awk '/policy_access/ {print $2}')
policy_mgmt_pid=$(neutron port-list | awk '/policy_mgmt/ {print $2}')

nova boot --flavor m1.mlittle --image trusty-server-cloudimg-amd64-disk1.img \
        --nic port-id=$policy_access_pid \
        --nic port-id=$policy_mgmt_pid \
        --key-name cognet policy

sleep 2s
