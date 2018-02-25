#!/bin/bash
#
# Neutron port creation script for CogNet components with fixed IPs for Openstack host.
# to run the script /root/keystonerc_admin file should be sourced.

echo "Neutron creates ports for DOCKER.."
echo '------------------------------'

neutron port-create access --name docker_access --fixed-ip ip_address=192.168.7.3

neutron port-create mgmt --name docker_mgmt \
	--fixed-ip ip_address=192.168.254.3



echo "Neutron creates ports for KAFKA.."
echo '------------------------------'

neutron port-create access --name kafka_access --fixed-ip ip_address=192.168.7.5

neutron port-create mgmt --name kafka_mgmt \
	--fixed-ip ip_address=192.168.254.5



echo "Neutron creates ports for POLICY.."
echo '------------------------------'

neutron port-create access --name policy_access --fixed-ip ip_address=192.168.7.6

neutron port-create mgmt --name policy_mgmt \
	--fixed-ip ip_address=192.168.254.6


echo "Neutron creates ports for ML.."
echo '------------------------------'

neutron port-create access --name ml_access --fixed-ip ip_address=192.168.7.7

neutron port-create mgmt --name ml_mgmt \
	--fixed-ip ip_address=192.168.254.7


echo "Neutron creates ports for MONASCA.."
echo '------------------------------'

neutron port-create access --name monasca_access --fixed-ip ip_address=192.168.7.8

neutron port-create mgmt --name monasca_mgmt \
	--fixed-ip ip_address=192.168.254.8



echo "Neutron creates ports for ODL.."
echo '------------------------------'

neutron port-create access --name odl_access --fixed-ip ip_address=192.168.7.9

neutron port-create mgmt --name odl_mgmt \
	--fixed-ip ip_address=192.168.254.9








