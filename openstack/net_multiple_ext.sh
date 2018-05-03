#!/bin/bash

# Task: Creating multiple external networks on OpenStack

source ~/keystonerc_admin


neutron net-create external_2 --provider:network_type flat --shared --provider:physical_network extnet2 --router:external

neutron subnet-create --name ext2_subnet --enable_dhcp=False --allocation-pool=start=192.168.1.10,end=192.168.1.100 --gateway=192.168.1.1 external_2 192.168.1.0/24

sleep 1s 

neutron net-create external_3 --provider:network_type flat --shared --provider:physical_network extnet3 --router:external

neutron subnet-create --name ext3_subnet --enable_dhcp=False --allocation-pool=start=192.168.4.10,end=192.168.4.100 --gateway=192.168.4.1  external_3 192.168.4.0/24

sleep 1s 


neutron net-update external_network --shared

neutron router-create router_2

neutron router-gateway-set router_2 external_2

neutron net-create int_2

neutron subnet-create --name int2_sub int_2 192.168.8.0/24

neutron router-interface-add router_2 int2_sub

sleep 2s

neutron router-create router_3

neutron router-gateway-set router_3 external_3

neutron net-create int_3

neutron subnet-create --name int3_sub int_3 192.168.9.0/24

neutron router-interface-add router_3 int3_sub

sleep 2s

#neutron port-create internal_network --name t1_int --fixed-ip ip_address=192.168.7.21

#neutron port-create internal_network --name t2_int --fixed-ip ip_address=192.168.7.22


echo -e "\n------------Updated network list----------"

sleep 2s

neutron net-list

neutron subnet-list

echo -e "\n------------Updated router list----------"

neutron router-list
sleep 2s

echo -e "\n--For updated ports: <$ openstack port list>--" 
