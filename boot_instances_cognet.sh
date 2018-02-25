#!/bin/bash
#
# Nova instance booting script for CogNet components on Openstack host.
# to run the script /root/keystonerc_admin file should be sourced.


echo -e "\nNova controller is booting DOCKER instance.."
echo '-------------------------------'

docker_access_pid=$(neutron port-list | awk '/docker_access/ {print $2}')
docker_mgmt_pid=$(neutron port-list | awk '/docker_mgmt/ {print $2}')

nova boot --flavor m1.mlittle --image 	xenial-server-cloudimg-amd-dick1.img \
	--nic port-id=$docker_access_pid \
	--nic port-id=$docker_mgmt_pid \
	--key-name cognet docker

sleep 2s

echo -e "\nNova controller is booting KAFKA instance.."
echo '-------------------------------'

kafka_access_pid=$(neutron port-list | awk '/kafka_access/ {print $2}')
kafka_mgmt_pid=$(neutron port-list | awk '/kafka_mgmt/ {print $2}')

nova boot --flavor m1.mlittle --image 	xenial-server-cloudimg-amd-dick1.img \
	--nic port-id=$kafka_access_pid \
	--nic port-id=$kafka_mgmt_pid \
	--key-name cognet kafka

sleep 2s

echo -e "\nNova controller is booting POLICY instance.."
echo '-------------------------------'

policy_access_pid=$(neutron port-list | awk '/policy_access/ {print $2}')
policy_mgmt_pid=$(neutron port-list | awk '/policy_mgmt/ {print $2}')

nova boot --flavor m1.mlittle --image 	xenial-server-cloudimg-amd-dick1.img \
	--nic port-id=$policy_access_pid \
	--nic port-id=$policy_mgmt_pid \
	--key-name cognet policy

sleep 2s

echo -e "\nNova controller is booting ML instance.."
echo '-------------------------------'

ml_access_pid=$(neutron port-list | awk '/ml_access/ {print $2}')
ml_mgmt_pid=$(neutron port-list | awk '/ml_mgmt/ {print $2}')

nova boot --flavor m1.mlittle --image 	xenial-server-cloudimg-amd-dick1.img \
	--nic port-id=$ml_access_pid \
	--nic port-id=$ml_mgmt_pid \
	--key-name cognet ml

sleep 2s

echo -e "\nNova controller is booting MONASCA instance.."
echo '-------------------------------'

monasca_access_pid=$(neutron port-list | awk '/monasca_access/ {print $2}')
monasca_mgmt_pid=$(neutron port-list | awk '/monasca_mgmt/ {print $2}')

nova boot --flavor m1.mlittle --image 	xenial-server-cloudimg-amd-dick1.img \
	--nic port-id=$monasca_access_pid \
	--nic port-id=$monasca_mgmt_pid \
	--key-name cognet monasca

sleep 2s

echo -e "\nNova controller is booting ODL instance.."
echo '-------------------------------'

odl_access_pid=$(neutron port-list | awk '/odl_access/ {print $2}')
odl_mgmt_pid=$(neutron port-list | awk '/odl_mgmt/ {print $2}')

nova boot --flavor m1.mlittle --image 	xenial-server-cloudimg-amd-dick1.img \
	--nic port-id=$odl_access_pid \
	--nic port-id=$odl_mgmt_pid \
	--key-name cognet odl

sleep 2s