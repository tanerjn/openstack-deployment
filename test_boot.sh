#!/bin/bash

#Task: Launch of instances

source ~/keystonerc_admin

ins1_name='ubuntu'
ins2_name='cirros'



nova flavor-create m1.little 6 1024 5 1 --swap 1024 --is-public True
nova flavor-create m1.mini 7 1024 10 1 --is-public True
nova flavor-create m1.midi 8 2048 10 1 --is-public True

echo "Neutron creates ports for "${ins1_name}" .."
echo '------------------------------'

neutron port-create internal_network --name c_port --fixed-ip ip_address=192.168.7.55

sleep 1s

echo "Neutron creates ports for "${ins2_name}".."
echo '------------------------------'

neutron port-create internal_network --name u_port --fixed-ip ip_address=192.168.7.66

sleep 1s

echo -e "\nNova controller is booting "${ins1_name}" ..."
echo '-------------------------------'

t1_int_pid=$(neutron port-list | awk '/u_port/ {print $2}')
#t1_ext2_pid=$(neutron port-list | awk '/t1_ext2/ {print $2}')
#t1_ext3_pid=$(neutron port-list | awk '/t1_ext3/ {print $2}')

nova boot --flavor m1.midi --image ubuntu16 \
        --nic port-id=$t1_int_pid \
        --key-name stack $ins1_name

sleep 2s


echo -e "\nNova controller is booting "${ins2_name}" ..."
echo '-------------------------------'

t2_int_pid=$(neutron port-list | awk '/c_port/ {print $2}')
#t2_ext2_pid=$(neutron port-list | awk '/t2_ext2/ {print $2}')
#t2_ext3_pid=$(neutron port-list | awk '/t2_ext3/ {print $2}')

#nova boot --flavor m1.tiny --image cirros \
        --nic port-id=$t2_int_pid \
        --key-name stack $ins2_name

echo -e "\n------------Updated Instance list----------"

sleep 2s

nova list
