#!/bin/bash

#OpenStack installation script with packstack installer for CentOS7.

echo -e "\n Installation will take around 30 min."

sleep 3s

LANG=en_US.utf-8
LC_ALL=en_US.utf-8

export USR=${USER}

echo -e "Root "



sudo echo "$USR ALL=(ALL) ALL" | sudo EDITOR='tee -a' visudo



sudo usermod -aG wheel $USER

sudo sed -i -e  's/enforcing/disabled/g' /etc/selinux/config 

sudo yum install python-pip

sudo yum install python-setuptools

sudo systemctl disable firewalld 
sleep 1s
sudo systemctl stop firewalld
sleep 1s
sudo systemctl disable NetworkManager
sleep 1s
sudo systemctl stop NetworkManager
sleep 1s
sudo systemctl enable network 
sleep 1s
sudo systemctl start network 
sleep 1s
sudo yum install -y https://rdoproject.org/repos/rdo-release.rpm

sudo yum install -y centos-release-openstack-queens

yum-config-manager --enable openstack-queens 

sudo yum update -y 

sudo yum install -y openstack-packstack

packstack --allinone --provision-demo=n --os-neutron-ovs-bridge-mappings=extnet:br-ex --os-neutron-ovs-bridge-interfaces=br-ex:eth0 --os-neutron-ml2-type-drivers=vxlan,flat

echo -e "\n***************\n Check the last log.\n *************** \n If no error occurs, installation can be followed with net_init.sh script.\n ************* \n Before that reboot is required\n ***************\n" 
