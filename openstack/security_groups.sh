#!/bin/bash

source ~/keystonerc_admin

openstack security group rule create default --protocol tcp --dst-port 22:22 --remote-ip 0.0.0.0/0

openstack security group rule create  default --protocol tcp --dst-port 443:443 --remote-ip 0.0.0.0/0

openstack security group rule create  default --protocol icmp






openstack security group rule list default
 
