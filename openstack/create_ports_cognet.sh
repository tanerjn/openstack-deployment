#!/bin/bash
#
#
# Neutron port creation script for CogNet components with fixed IPs for Openstack host.
# to run the script keystonerc_admin file is sourced. If the file is in different location, path should be modified.
#
#| id                                   | name             | tenant_id                        | subnets                                               |
#--------------------------------------+------------------+----------------------------------+-------------------------------------------------------+
#| 59fc5179-a7cf-4ba5-8a23-8d45a70a3cd1 | external_network | 625cda8f5bc74173a1c209a2bc044d87 | c20d3976-3bdb-44e2-aaf8-8b346d18fe29 192.168.149.0/24 |
#| ab931c5c-cbf0-4ad2-b73b-d4c7e574af72 | internal_network | 625cda8f5bc74173a1c209a2bc044d87 | 7cf7e26c-fbe9-4fc1-9b40-a4b2da50d7aa 192.168.7.0/24  
#



scriptPATH=$(dirname $(readlink -f $0))

. $scriptPATH/agnosticCI.conf

source $scriptPATH/$cloud_credential_file

echo "Neutron creates ports for DOCKER.."
echo '------------------------------'

neutron port-create internal_network --name docker_internal --fixed-ip ip_address=192.168.7.3

# neutron port-create mgmt --name docker_mgmt \
# 	--fixed-ip ip_address=192.168.254.3



echo "Neutron creates ports for KAFKA.."
echo '------------------------------'

neutron port-create internal_network --name kafka_internal --fixed-ip ip_address=192.168.7.4

# neutron port-create mgmt --name kafka_mgmt \
# 	--fixed-ip ip_address=192.168.254.4



echo "Neutron creates ports for POLICY.."
echo '------------------------------'

neutron port-create internal_network --name policy_internal --fixed-ip ip_address=192.168.7.5

# neutron port-create mgmt --name policy_mgmt \
# 	--fixed-ip ip_address=192.168.254.5


echo "Neutron creates ports for SPARK-MASTER.."
echo '------------------------------'

neutron port-create internal_network --name sp_master_internal --fixed-ip ip_address=192.168.7.6

# neutron port-create mgmt --name sp_master_internal \
# 	--fixed-ip ip_address=192.168.254.7

echo "Neutron creates ports for SPARK-SLAVE1.."
echo '------------------------------'

neutron port-create internal_network --name sp_1_internal --fixed-ip ip_address=192.168.7.7

# neutron port-create mgmt --name sp_1_internal \
# 	--fixed-ip ip_address=192.168.254.7

echo "Neutron creates ports for SPARK-SLAVE2.."
echo '------------------------------'

neutron port-create internal_network --name sp_2_internal --fixed-ip ip_address=192.168.7.8

# neutron port-create mgmt --name sp_2_internal \
# 	--fixed-ip ip_address=192.168.254.7


echo "Neutron creates ports for OSCON.."
echo '------------------------------'

neutron port-create internal_network --name oscon_internal --fixed-ip ip_address=192.168.7.9

# neutron port-create mgmt --name OSCON_mgmt \
# 	--fixed-ip ip_address=192.168.254.8

echo "Neutron creates ports for MONASCA.."
echo '------------------------------'

neutron port-create internal_network --name monasca_internal --fixed-ip ip_address=192.168.7.10

# neutron port-create mgmt --name monasca_mgmt \
# 	--fixed-ip ip_address=192.168.254.8


echo "Neutron creates ports for OPENDAYLIGHT.."
echo '------------------------------'

neutron port-create internal_network --name odl_internal --fixed-ip ip_address=192.168.7.11

# neutron port-create mgmt --name odl_mgmt \
# 	--fixed-ip ip_address=192.168.254.9

#'Ports were created, it can be checked with "openstack port list" command'

openstack port list
