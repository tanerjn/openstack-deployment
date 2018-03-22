#!/bin/bash
#
# Nova instance booting script for CogNet components on Openstack host.
# to run the script keystonerc_admin file is sourced. If the file is in different location, path should be modified.
#
#| ID | Name      |   RAM | Disk | Ephemeral | VCPUs |
#| 6  | t.little  |  2048 |   15 |         0 |     1 |  
#| 7  | t.small   |  1024 |   10 |         0 |     1 |   
#| 8  | t.tiny    |  1024 |    5 |         0 |     1 |
#| 9  | t.mini    |  2048 |   10 |         0 |     1 | 


scriptPATH=$(dirname $(readlink -f $0))

#. $scriptPATH/agnosticCI.conf

#source $scriptPATH/$cloud_credential_file
source $scriptPATH/cred/keystonerc_admin

echo -e "\nNova controller is booting DOCKER instance.."
echo '-------------------------------'

docker_internal_pid=$(neutron port-list | awk '/docker_internal/ {print $2}')

nova boot --flavor t.little --image ubuntu16 \
	--nic port-id=$docker_internal_pid \
	--key-name cognet docker

sleep 10s

echo -e "\nNova controller is booting KAFKA instance.."
echo '-------------------------------'

kafka_internal_pid=$(neutron port-list | awk '/kafka_internal/ {print $2}')

nova boot --flavor t.little --image 	ubuntu16 \
	--nic port-id=$kafka_internal_pid \
	--key-name cognet kafka

sleep 10s

echo -e "\nNova controller is booting POLICY instance.."
echo '-------------------------------'

policy_internal_pid=$(neutron port-list | awk '/policy_internal/ {print $2}')

nova boot --flavor t.small --image trusty14\
	--nic port-id=$policy_internal_pid \
	--key-name cognet policy

sleep 10s

echo -e "\nNova controller is booting SPARK-MASTER instance.."
echo '-------------------------------'

sp_master_internal_pid=$(neutron port-list | awk '/sp_master_internal/ {print $2}')

nova boot --flavor t.small --image 	ubuntu16 \
	--nic port-id=$sp_master_internal_pid \
	--key-name cognet spark_master

echo -e "\nNova controller is booting SPARK-SLAVE1 instance.."
echo '-------------------------------'

sp_1_internal_pid=$(neutron port-list | awk '/sp_1_internal/ {print $2}')

nova boot --flavor t.tiny --image 	ubuntu16 \
	--nic port-id=$sp_1_internal_pid \
	--key-name cognet spark_slaves1

echo -e "\nNova controller is booting SPARK-SLAVE2 instance.."
echo '-------------------------------'

sp_2_internal_pid=$(neutron port-list | awk '/sp_2_internal/ {print $2}')

nova boot --flavor t.tiny --image 	ubuntu16 \
	--nic port-id=$sp_2_internal_pid \
	--key-name cognet spark_slaves2

sleep 10s


echo -e "\nNova controller is booting OSCON instance.."
echo '-------------------------------'

oscon_internal_pid=$(neutron port-list | awk '/oscon_internal/ {print $2}')

nova boot --flavor t.small --image 	ubuntu16 \
	--nic port-id=$oscon_internal_pid \
	--key-name cognet oscon

sleep 10s

echo -e "\nNova controller is booting MONASCA instance.."
echo '-------------------------------'

monasca_internal_pid=$(neutron port-list | awk '/monasca_internal/ {print $2}')

nova boot --flavor t.small --image 	ubuntu16 \
	--nic port-id=$monasca_internal_pid \
	--key-name cognet monasca

sleep 10s

echo -e "\nNova controller is booting OPENDAYLIGHT instance.."
echo '-------------------------------'

odl_internal_pid=$(neutron port-list | awk '/odl_internal/ {print $2}')

nova boot --flavor t.small --image 	ubuntu16 \
	--nic port-id=$odl_internal_pid \
	--key-name cognet odl

sleep 10s

nova list


