#!/bin/bash

# openvswitch configurations

sudo cp ifcfg-eth1 /etc/sysconfig/network-scripts/
sudo cp ifcfg-eth2 /etc/sysconfig/network-scripts/
sudo cp ifcfg-br-ext3 /etc/sysconfig/network-scripts/
sudo cp ifcfg-br-ext3 /etc/sysconfig/network-scripts/



ovs-vsctl add-br br-ext2
ovs-vsctl add-port br-ext2 eth1
ovs-vsctl add-br br-ext3
ovs-vsctl add-port br-ext3 eth2

sudo mv /etc/neutron/l3_agent.ini /etc/neutron/l3_agent.ini.backup
sudo cp l3_agent.ini /etc/neutron/

sudo mv /etc/neutron/plugins/ml2/openvswitch_agent.ini /etc/neutron/plugins/ml2/openvswitch_agent.ini.backup
sudo cp openvswitch_agent.ini /etc/neutron/plugins/ml2/

sudo mv /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugins/ml2/ml2_conf.ini.backup
sudo cp ml2_conf.ini /etc/neutron/plugins/ml2/

