#!/bin/bash
#
# Neutron port creation script with 5G core network fixed IPs for Openstack host.



source ~/keystonerc_admin 

echo "mgmt interface"
echo '------------------------------'

neutron net-create mgmt
neutron subnet-create --name mgmt_subnet mgmt 192.168.254.0/24 

echo "net_a interface"
echo '------------------------------'

neutron net-create net_a
neutron subnet-create --name net_a_subnet net_a 192.168.1.0/24 

echo "net_b interface"
echo '------------------------------'

neutron net-create net_b
neutron subnet-create --name net_b_subnet net_b 192.168.2.0/24 

echo "net_c interface"
echo '------------------------------'

neutron net-create net_c
neutron subnet-create --name net_c_3_subnet net_c 192.168.3.0/24
neutron subnet-create --name net_c_6_subnet net_c 192.168.6.0/24 


echo "net_d interface"
echo '------------------------------'

neutron net-create net_d
neutron subnet-create --name net_d_subnet net_d 192.168.4.0/24 

echo "access interface"
echo '------------------------------'

neutron net-create access
neutron subnet-create --name access_subnet access 192.168.7.0/24

neutron router-interface-add router1 private_subnet

echo "router"

neutron router-create router
neutron router-gateway-set router external_network

neutron router-interface-add router mgmt
neutron router-interface-add router access



echo '-------Creating ports for instances-------'

echo "Neutron creates ports for BASE.."
echo '------------------------------'

neutron port-create access --name base_access --fixed-ip ip_address=192.168.7.77

neutron port-create mgmt --name base_mgmt \
	--fixed-ip ip_address=192.168.254.77

neutron port-create net_a --name base_net_a \
	--fixed-ip ip_address=192.168.1.77

neutron port-create net_b --name base_net_b \
	--fixed-ip ip_address=192.168.2.77

neutron port-create net_c --name base_net_c \
	--fixed-ip ip_address=192.168.3.77

neutron port-create net_d --name base_net_d \
	--fixed-ip ip_address=192.168.4.77

echo -e "\nNeutron creates ports for INET-GW.."
echo '----------------------------------------'

neutron port-create access --name inet_access --fixed-ip ip_address=192.168.7.30

neutron port-create mgmt  --name inet_mgmt \
	--fixed-ip ip_address=192.168.254.30 --fixed-ip ip_address=192.168.254.105 \
        --fixed-ip ip_address=192.168.254.31 --fixed-ip ip_address=192.168.254.32 \
        --fixed-ip ip_address=192.168.254.40 --fixed-ip ip_address=192.168.254.41 \
        --fixed-ip ip_address=192.168.254.42 --fixed-ip ip_address=192.168.254.43 \
        --fixed-ip ip_address=192.168.254.44 --fixed-ip ip_address=192.168.254.50 \
        --fixed-ip ip_address=192.168.254.51 --fixed-ip ip_address=192.168.254.52 

neutron port-create net_a --name inet_net_a \
	--fixed-ip ip_address=192.168.1.30 \
        --fixed-ip ip_address=192.168.1.31 --fixed-ip ip_address=192.168.1.32 \
        --fixed-ip ip_address=192.168.1.40 --fixed-ip ip_address=192.168.1.41  \
        --fixed-ip ip_address=192.168.1.42 --fixed-ip ip_address=192.168.1.43


echo -e "\nNeutron creates ports for MME1"
echo '------------------------------'

neutron port-create access --name mme1_access --fixed-ip ip_address=192.168.7.80

neutron port-create mgmt --name mme1_mgmt \
	--fixed-ip ip_address=192.168.254.80 --fixed-ip ip_address=192.168.254.10 \
	--fixed-ip ip_address=192.168.254.20 

neutron port-create net_d --name mme1_net_d \
	--fixed-ip ip_address=192.168.4.80 --fixed-ip ip_address=192.168.4.20


echo -e "\nNeutron creates ports for MME2.."
echo '--------------------------------'

neutron port-create access --name mme2_access --fixed-ip ip_address=192.168.7.81


neutron port-create mgmt --name mme2_mgmt --fixed-ip ip_address=192.168.254.81 \
	--fixed-ip ip_address=192.168.254.19 \
	--fixed-ip ip_address=192.168.254.11 

neutron port-create net_d --name mme2_net_d --fixed-ip ip_address=192.168.4.81 --fixed-ip ip_address=192.168.4.19 


echo -e "\nNeutron creates ports for MME-LB.."
echo '---------------------------------'

neutron port-create access --name mmelb_access --fixed-ip ip_address=192.168.7.60

neutron port-create mgmt --name mmelb_mgmt \
	--fixed-ip ip_address=192.168.254.60 

neutron port-create net_d --name mmelb_net_d \
	--fixed-ip ip_address=192.168.4.60 


echo -e "\nNeutron create ports for HSS.."
echo '-------------------------------'

neutron port-create access --name hss_access --fixed-ip ip_address=192.168.7.70

neutron port-create mgmt --name hss_mgmt \
	--fixed-ip ip_address=192.168.254.70 --fixed-ip ip_address=192.168.254.71


echo -e "\nNeutron creates ports for BT.."
echo '------------------------------'

neutron port-create access --name bt_access --fixed-ip ip_address=192.168.7.110

neutron port-create mgmt --name bt_mgmt \
	--fixed-ip ip_address=192.168.254.110 

neutron port-create net_d --name bt_net_d \
	--fixed-ip ip_address=192.168.4.110 --fixed-ip ip_address=192.168.4.111 \
	--fixed-ip ip_address=192.168.4.112 --fixed-ip ip_address=192.168.4.113 \
	--fixed-ip ip_address=192.168.4.114 --fixed-ip ip_address=192.168.4.115 

echo -e "\nNeutron creates ports for DP-SWITCH.."
echo '-------------------------------------'

neutron port-create access --name switch1_access --fixed-ip  ip_address=192.168.7.210

neutron port-create mgmt --name switch1_mgmt \
		--fixed-ip  ip_address=192.168.254.210 --fixed-ip ip_address=192.168.254.220

neutron port-create net_a --name switch1_net_a \
		--fixed-ip  ip_address=192.168.1.210 --fixed-ip ip_address=192.168.1.220

neutron port-create net_d --name switch1_net_d \
		--fixed-ip  ip_address=192.168.4.210 --fixed-ip ip_address=192.168.4.220


echo -e "\nNeutron creates ports for O5GC-GUI.."
echo '------------------------------------'
neutron port-create access --name gui_access --fixed-ip ip_address=192.168.7.175

neutron port-create mgmt --name gui_mgmt --fixed-ip ip_address=192.168.254.175


openstack port list

neutron net-list

echo '------------------------------------'
echo -e '\nProcess has finished. You can check your networks and ports above as with "neutron port-list" or "openstack port list" commands.\n'


