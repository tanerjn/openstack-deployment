#!/bin/bash

# Task: Creating multiple external networks on OpenStack

source ~/keystonerc_admin



neutron net-create external_2 --provider:network_type flat --provider:physical_network extnet2 --router:external

neutron net-create external_3 --provider:network_type flat --provider:physical_network extnet3 --router:external


neutron subnet-create --name ext2_subnet --enable_dhcp=False --allocation-pool=start=192.168.1.3,end=192.168.1.30 --gateway=192.168.1.1 external_2 192.168.1.0/24

neutron subnet-create --name ext3_subnet --enable_dhcp=False --allocation-pool=start=192.168.4.3,end=192.168.4.30 --gateway=192.168.4.1 external_3 192.168.4.0/24


neutron router-interface-add router ext2_subnet

neutron router-interface-add router ext3_subnet


neutron port-create internal_network --name t1_int --fixed-ip ip_address=192.168.7.21

neutron port-create internal_network --name t2_int --fixed-ip ip_address=192.168.7.22

neutron port-create external_2 --name t1_ext2 --fixed-ip ip_address=192.168.1.21

neutron port-create external_3 --name t1_ext3 --fixed-ip ip_address=192.168.4.21

neutron port-create external_2 --name t2_ext2 --fixed-ip ip_address=192.168.1.22

neutron port-create external_3 --name t2_ext3 --fixed-ip ip_address=192.168.4.22

echo -e "\n------------Updated network list----------"

sleep 2s

neutron net-list

neutron subnet-list

echo -e "\n------------Updated port list----------"

neutron port-list
sleep 2s
