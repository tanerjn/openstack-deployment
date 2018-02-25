#!/bin/bash

#Nova instance booting script for 5G components on Openstack host.
#to run the script /root/keystonerc_admin file should be sourced.

echo -e "\nNova controller is booting INET-GW instance.."
echo '-------------------------------'

inet_access_pid=$(neutron port-list | awk '/inet_access/ {print $2}')
inet_mgmt_pid=$(neutron port-list | awk '/inet_mgmt/ {print $2}')
inet_net_a_pid=$(neutron port-list | awk '/inet_net_a/ {print $2}')

nova boot --flavor m1.blittle --image 5G_core_image \
	--nic port-id=$inet_access_pid \
	--nic port-id=$inet_mgmt_pid \
	--nic port-id=$inet_net_a_pid \
	--key-name cognet inet-gw
sleep 2s

echo -e "\nNova controller is booting MME1 instance.."
echo '----------------------------'

mme1_access_pid=$(neutron port-list | awk '/mme1_access/ {print $2}')
mme1_mgmt_pid=$(neutron port-list | awk '/mme1_mgmt/ {print $2}')
mme1_net_d_pid=$(neutron port-list | awk '/mme1_net_d/ {print $2}')

nova boot --flavor m1.blittle --image 5G_core_image \
	--nic port-id=$mme1_access_pid \
	--nic port-id=$mme1_mgmt_pid \
	--nic port-id=$mme1_net_d_pid \
	--key-name cognet mme1
sleep 2s

echo -e "\nNova controller is booting MME2 instance.."
echo '----------------------------'
mme2_access_pid=$(neutron port-list | awk '/mme2_access/ {print $2}')
mme2_mgmt_pid=$(neutron port-list | awk '/mme2_mgmt/ {print $2}')
mme2_net_d_pid=$(neutron port-list | awk '/mme2_net_d/ {print $2}')

nova boot --flavor m1.blittle --image 5G_core_image \
	--nic port-id=$mme2_access_pid \
	--nic port-id=$mme2_mgmt_pid \
	--nic port-id=$mme2_net_d_pid \
	--key-name cognet mme2
sleep 2s

echo -e "\nNova controller is booting MME-LB instance.."
echo '----------------------------'
mme_lb_access_pid=$(neutron port-list | awk '/mmelb_access/ {print $2}')
mme_lb_mgmt_pid=$(neutron port-list | awk '/mmelb_mgmt/ {print $2}')
mme_lb_net_d_pid=$(neutron port-list | awk '/mmelb_net_d/ {print $2}')

nova boot --flavor m1.blittle --image 5G_core_image \
	--nic port-id=$mme_lb_access_pid \
	--nic port-id=$mme_lb_mgmt_pid \
	--nic port-id=$mme_lb_net_d_pid \
	--key-name cognet mme-lb
sleep 2s

echo -e "\nNova controller is booting HSS instance.."
echo '-------------------------- '
hss_access_pid=$(neutron port-list | awk '/hss_access/ {print $2}')
hss_mgmt_pid=$(neutron port-list | awk '/hss_mgmt/ {print $2}')


nova boot --flavor m1.blittle --image 5G_core_image \
	--nic port-id=$hss_access_pid \
	--nic port-id=$hss_mgmt_pid \
	--key-name cognet hss
sleep 2s

echo -e "\nNova controller is booting BT instance.."
echo '-------------------------------'
bt_access_pid=$(neutron port-list | awk '/bt_access/ {print $2}')
bt_mgmt_pid=$(neutron port-list | awk '/bt_mgmt/ {print $2}')
bt_net_d_pid=$(neutron port-list | awk '/bt_net_d/ {print $2}')

nova boot --flavor m1.blittle --image 5G_core_image \
	--nic port-id=$bt_access_pid \
	--nic port-id=$bt_mgmt_pid \
	--nic port-id=$bt_net_d_pid \
	--key-name cognet bt
sleep 2s

echo -e "\nNova controller is booting DP-SWITCH instance.."
echo '--------------------------------------'
switch1_access_pid=$(neutron port-list | awk '/switch1_access/ {print $2}')
switch1_mgmt_pid=$(neutron port-list | awk '/switch1_mgmt/ {print $2}')
switch1_net_a_pid=$(neutron port-list | awk '/switch1_net_a/ {print $2}')
switch1_net_d_pid=$(neutron port-list | awk '/switch1_net_d/ {print $2}')

nova boot --flavor m1.blittle --image 5G_core_image \
	--nic port-id=$switch1_access_pid \
	--nic port-id=$switch1_mgmt_pid \
	--nic port-id=$switch1_net_a_pid \
	--nic port-id=$switch1_net_d_pid \
	--key-name cognet dp-switch1
sleep 2s

echo -e "\nNova controller is booting O5GC-GUI instance.."
echo '-------------------------------------'

gui_access_pid=$(neutron port-list | awk '/gui_access/ {print $2}')
gui_mgmt_pid=$(neutron port-list | awk '/gui_mgmt/ {print $2}')

nova boot --flavor m1.blittle --image 5G_core_image \
	--nic port-id=$gui_access_pid \
	--nic port-id=$gui_mgmt_pid \
	--key-name cognet o5gc-gui
sleep 2s

echo -e '\nBooting completed. You can check your instances with "nova list" command.\n'