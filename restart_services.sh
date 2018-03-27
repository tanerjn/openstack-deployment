#!/bin/bash

#Compute services 

sudo service openstack-nova-api restart
sudo service openstack-nova-compute restart
#sudo service nova-cert restart
sudo service openstack-nova-consoleauth restart
sudo service openstack-nova-scheduler restart
sudo service openstack-nova-conductor restart
sudo service openstack-nova-novncproxy restart


#Networking services

sudo service neutron-server restart
sudo service neutron-dhcp-agent restart
sudo service neutron-l3-agent restart
sudo service neutron-metadata-agent restart
sudo service neutron-openvswitch-agent restart

#Cinder(Block storage) services 

sudo service openstack-cinder-api restart
sudo service openstack-cinder-backup  restart
sudo service openstack-cinder-scheduler restart
sudo service openstack-cinder-volume restart

service openstack-nova-compute status
service neutron-server status

