#!/bin/bash

#OpenStack installation script with packstack installer for CentOS7.

echo -e "\n Installation will take around 40 min."

sleep 3s

LANG=en_US.utf-8
LC_ALL=en_US.utf-8

sudo systemctl disable firewalld 

sudo systemctl stop firewawlld

sudo systemctl disable NetworkManager

sudo systemctl stop NetworkManager

sudo systemctl enable network 

sudo systemctl start network 

sudo yum install -y https://rdoproject.org/repos/rdo-release.rpm

sudo yum install -y centos-release-openstack-queens

yum-config-manager --enable openstack-queens 

sudo yum update -y 

sudo yum install -y openstack-packstack

packstack --allinone --provision-demo=n --os-neutron-ovs-bridge-mappings=extnet:br-ex --os-neutron-ovs-bridge-interfaces=br-ex:eth0 --os-neutron-ml2-type-drivers=vxlan,flat

