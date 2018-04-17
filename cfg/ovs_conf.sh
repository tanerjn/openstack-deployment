#!/bin/bash

# openvswitch configurations

ovs-vsctl add-br br-ext2
ovs-vsctl add-port br-ext2 ext2
ovs-vsctl add-br br-ext3
ovs-vsctl add-port br-ext3 ext3

sudo mv /etc/neutron/l3_agent.ini /etc/neutron/l3_agent.ini.backup
sudo cp l3_agent.ini /etc/neutron/

sudo mv /etc/neutron/plugins/ml2/openvswitch_agent.ini /etc/neutron/plugins/ml2/openvswitch_agent.ini.backup
sudo cp openvswitch_agent.ini /etc/neutron/plugins/ml2/

sudo mv /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugins/ml2/ml2_conf.ini.backup
sudo cp ml2_conf.ini /etc/neutron/plugins/ml2/

