#!/bin/bash
#
# Initialization of external & internal network. Check the interface name. 


#sudo mv /etc/sysconfig/network-scripts/ifcfg-eth0 /etc/sysconfig/network-scripts/ifcfg-eth0.backup

#sudo mv /etc/sysconfig/network-scripts/ifcfg-br-ex /etc/sysconfig/network-scripts/ifcfg-br-ex.backup

#sudo cp cfg/ifcfg-eth0 /etc/sysconfig/network-scripts/

#sudo cp cfg/ifcfg-br-ex /etc/sysconfig/network-scripts/

#service network restart


source ~/keystonerc_admin

neutron net-create external_network --provider:network_type flat --provider:physical_network extnet  --router:external
sleep 1s 

neutron subnet-create --name external_subnet --enable_dhcp=False --allocation-pool=start=192.168.254.10,end=192.168.254.30 --gateway=192.168.254.2 external_network 192.168.254.0/24
sleep 1s

neutron router-create router

neutron router-gateway-set router external_network

neutron net-create internal_network

neutron subnet-create --name internal_subnet internal_network 192.168.7.0/24

neutron router-interface-add router internal_subnet

echo "----------Updated net list--------"
sleep 2s

neutron net-list


echo "---------Updated subnet list--------"
neutron subnet-list
