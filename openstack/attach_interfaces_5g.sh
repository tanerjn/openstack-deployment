#!/bin/bash
#
# Nova controller script to attach 5G core interfaces.
# script should be run if network interfaces are not attached as launching instance.
# to run, /root/keystonerc_admin file should be sourced.

echo "Nova attaches interfaces for BASE.."
echo '-----------------------------------'

base_mgmt_pid=$(neutron port-list | awk '/192.168.254.77/ {print $2}')
nova interface-attach inet-gw --port-id=$inet_mgmt_pid

base_net_a_pid=$(neutron port-list | awk '/192.168.1.77/ {print $2}')
nova interface-attach inet-gw --port-id=$base_net_a_pid

base_net_b_pid=$(neutron port-list | awk '/192.168.2.77/ {print $2}')
nova interface-attach inet-gw --port-id=$base_net_b_pid

base_net_c_pid=$(neutron port-list | awk '/192.168.3.77/ {print $2}')
nova interface-attach inet-gw --port-id=$base_net_c_pid

base_net_d_pid=$(neutron port-list | awk '/192.168.4.77/ {print $2}')
nova interface-attach inet-gw --port-id=$base_net_d_pid

sleep 2s 

echo "Nova attaches interfaces for INET-GW.."
echo '-----------------------------------'

inet_mgmt_pid=$(neutron port-list | awk '/192.168.254.30/ {print $2}')
nova interface-attach inet-gw --port-id=$inet_mgmt_pid

inet_net_a_pid=$(neutron port-list | awk '/192.168.1.30/ {print $2}')
nova interface-attach inet-gw --port-id=$inet_net_a_pid

sleep 2s

echo "Nova attaches interfaces for MME1.."
echo '-----------------------------------'

mme1_mgmt_pid=$(neutron port-list | awk '/192.168.254.80/ {print $2}')
nova interface-attach mme1 --port-id=$mme1_mgmt_pid

mme1_net_d_pid=$(neutron port-list | awk '/192.168.4.80/ {print $2}')
nova interface-attach mme1 --port-id=$mme1_net_d_pid


sleep 2s

echo "Nova attaches interfaces for MME2.."
echo '-----------------------------------'

mme2_mgmt_pid=$(neutron port-list | awk '/192.168.254.81/ {print $2}')
nova interface-attach mme2 --port-id=$mme2_mgmt_pid

mmme2_net_d_pid=$(neutron port-list | awk '/192.168.4.81/ {print $2}')
nova interface-attach mme2 --port-id=$mme2_net_d_pid

sleep 2s

echo "Nova attaches interfaces for MME-LB.."
echo '-----------------------------------'

mme_lb_mgmt_pid=$(neutron port-list | awk '/192.168.254.60/ {print $2}')
nova interface-attach mme-lb --port-id=$mme_lb_mgmt_pid

mme_lb_net_d_pid=$(neutron port-list | awk '/192.168.4.60/ {print $2}')
nova interface-attach mme-lb --port-id=$mme_lb_net_d_pid

sleep 2s 

echo "Nova attaches interfaces for HSS.."
echo '-----------------------------------'

hss_mgmt_pid=$(neutron port-list | awk '/192.168.254.70/ {print $2}')
nova interface-attach hss --port-id=$hss_mgmt_pid

sleep 2s

echo "Nova attaches interfaces for BT.."
echo '-----------------------------------'

bt_mgmt_pid=$(neutron port-list | awk '/192.168.254.110/ {print $2}')
nova interface-attach bt --port-id=$bt_mgmt_pid

bt_net_d_pid=$(neutron port-list | awk '/192.168.4.110/ {print $2}')
nova interface-attach bt --port-id=$bt_net_d_pid

sleep 2s

echo "Nova attaches interfaces for DP-SWITCH.."
echo '----------------------------------------'

switch_1_mgmt_pid=$(neutron port-list | awk '/192.168.254.210/ {print $2}')
nova interface-attach hss --port-id=$switch_1_mgmt_pid

switch_1_net_a_pid=$(neutron port-list | awk '/192.168.1.210/ {print $2}')
nova interface-attach hss --port-id=$switch_1_net_a_pid

switch_1_net_d_pid=$(neutron port-list | awk '/192.168.4.210/ {print $2}')
nova interface-attach hss --port-id=$switch_1_net_d_pid


sleep 2s

#o5gc-gui
echo "Nova attaches interfaces for O5GC-GUI.."
echo '---------------------------------------'

o5gc_gui_mgmt_pid=$(neutron port-list | awk '/192.168.254.175/ {print $2}')
nova interface-attach hss --port-id=$o5gc_gui_mgmt_pid

sleep 2s

echo 'Attaching interfaces finished. You can check your instances with "nova interface-list (mme1/mme2/bt..)" command.'