#!/bin/bash
#

# 
# Script for cleaning instances from OpenStack environment.
# to run the script keystonerc_admin file is sourced. If the file is in different location, path should be modified.
# Before and after running script, the status of the instances can be checked with 'nova list' command.

echo "Cleaning instances"

scriptPATH=$(dirname $(readlink -f $0))

. $scriptPATH/agnosticCI.conf

source $scriptPATH/$cloud_credential_file


echo " Removing Docker "
nova delete docker 
sleep 3s

echo " Removing Kafka "
nova delete kafka 
sleep 3s

echo " Removing Policy "
nova delete policy 
sleep 3s

echo " Removing Spark Master "
nova delete spark_master 
sleep 3s

echo " Removing Spark Slave 1 "
nova delete spark_slave1 
sleep 3s

echo " Removing Spark Slave 2 "
nova delete spark_slave2 
sleep 3s

echo " Removing OScon "
nova delete oscon 
sleep 3s

echo " Removing Monasca "
nova delete monasca 
sleep 3s

echo " Removing OpenDayLight "
nova delete odl 

nova list
