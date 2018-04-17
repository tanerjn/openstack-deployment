#!/bin/bash


source ~/keystonerc_admin

curl http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img | glance \
         image-create --name='cirros' --visibility=public --container-format=bare --disk-format=qcow2

echo -e "---------------\n For Cirros image, the login account is 'cirros', password is 'gocubsgo'\n---------------"


curl http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img | glance \
	image-create --name='ubuntu16' --visibility=public --container-format=bare --disk-format=qcow2


echo -e "---------------\n For Ubuntu image, the login account is 'ubuntu', no password is required\n---------------"
