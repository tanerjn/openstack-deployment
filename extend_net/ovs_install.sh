#!/bin/bash

# OpenvSwitch installation for Centos7. 
# note: not required for all flavors. check "ovs-vsctl -V" first. 

sudo su 

yum -y install wget openssl-devel gcc make python-devel openssl-devel kernel-devel graphviz kernel-debug-devel autoconf automake rpm-build redhat-rpm-config libtool python-twisted-core python-zope-interface PyQt4 desktop-file-utils libcap-ng-devel groff checkpolicy selinux-policy-devel

adduser ovs

su - ovs

#..downloads source code and prepares environment

mkdir -p ~/rpmbuild/SOURCES

wget http://openvswitch.org/releases/openvswitch-2.5.4.tar.gz

cp openvswitch-2.5.4.tar.gz ~/rpmbuild/SOURCES/

tar xfz openvswitch-2.5.4.tar.gz

rpmbuild -bb --nocheck openvswitch-2.5.4/rhel/openvswitch-fedora.spec

exit

#..continues as root, installs RPM package

yum localinstall /home/ovs/rpmbuild/RPMS/x86_64/openvswitch-2.5.4-1.el7.centos.x86_64.rpm -y

systemctl start openvswitch.service

#check answer
systemctl is-active openvswitch

systemctl enable openvswitch

ovs-vsctl -V

#overview of bridge-port configurations
ovs-vsctl show 