#!/bin/bash

# Task: Delete networks

source ~/keystonerc_admin

neutron port-delete $(neutron port-list | awk '/t1_int/ {print $2}')
neutron port-delete $(neutron port-list | awk '/t2_int/ {print $2}')
neutron port-delete $(neutron port-list | awk '/t1_ext2/ {print $2}')
neutron port-delete $(neutron port-list | awk '/t1_ext3/ {print $2}')
neutron port-delete $(neutron port-list | awk '/t2_ext2/ {print $2}')
neutron port-delete $(neutron port-list | awk '/t2_ext3/ {print $2}')


neutron router-interface-delete router ext2_subnet
sleep 1s
neutron router-interface-delete router ext3_subnet
sleep 1s



neutron net-delete external_2
sleep 1s
neutron net-delete external_3
sleep 1s

neutron subnet-delete ext2_subnet
sleep 1s
neutron subnet-delete ext3_subnet


echo -e "\n------------Updated network list----------"

sleep 2s

neutron net-list

neutron subnet-list

echo -e "\n------------Updated port list----------"

neutron port-list

sleep 2s
