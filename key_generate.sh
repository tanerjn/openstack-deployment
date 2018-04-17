#!/bin/bash



source ~/keystonerc_admin

openstack keypair create stack > ~/.ssh/stack.pem

sudo chmod 600 ~/.ssh/stack.pem

openstack keypair create --public-key ~/.ssh/id_rsa.pub stack

eval `ssh-agent -s`

ssh-add -q ~/.ssh/stack.pem

openstack keypair list


