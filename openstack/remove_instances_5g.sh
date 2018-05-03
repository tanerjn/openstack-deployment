#!/bin/bash
#

# 
# Script for cleaning instances from OpenStack environment.
# to run the script keystonerc_admin file is sourced. If the file is in different location, path should be modified.
# Before and after running script, the status of the instances can be checked with 'nova list' command.

echo "Cleaning instances"


source ~/keystonerc_admin

echo " Removing base"
nova delete base
sleep 3s

echo " Removing INET-GW "
nova delete inet-gw
sleep 3s

echo " Removing MME1 "
nova delete mme1
sleep 3s

echo " Removing MME2 "
nova delete mme2
sleep 3s

echo " Removing MME-LB "
nova delete mme-lb 
sleep 3s

echo " Removing HSS "
nova delete hss 
sleep 3s

echo " Removing BT"
nova delete bt
sleep 3s

echo " Removing DP-SWITCH1 "
nova delete dp-switch1
sleep 3s

echo " Removing O5GC-GUI "
nova delete o5gc-gui

nova list

