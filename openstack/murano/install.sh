#!/bin/bash

## Install Murano project into OpenStack

sudo usermod -aG wheel $USER

sudo apt-get install python-pip python-dev \
  libmysqlclient-dev libpq-dev \
  libxml2-dev libxslt1-dev \
  libffi-dev

sudo yum install gcc python-setuptools python-devel python-pip

sudo yum install gcc python-setuptools python-devel
sudo easy_install pip

sudo pip install tox

apt-get install python-mysqldb mysql-server

mysql -u root -p

mysql> CREATE DATABASE murano;
mysql> GRANT ALL PRIVILEGES ON murano.* TO centos@centos \
    IDENTIFIED BY 'murano';
mysql> exit;

mkdir ~/murano

cd ~/Murano

git clone git://git.openstack.org/openstack/murano

cd ~/murano/murano

tox -e genconfig

cd ~/murano/murano 

#CHECK CONF FILE
cp /opt/Open5Gcore/openstack/cfg/murano/murano.conf murano.conf

tox -e venv -- pip install PyMYSQL

cd ~/murano/murano/meta/

for i in */; do pushd ./"$i"; zip -r ../../"${i%/}.zip" *; popd; done
cd ..

tox -e venv -- murano --os-username %OPENSTACK_ADMIN_USER% \
--os-password $OPENSTACK_PASS% \
--os-auth-url http://$(OPENSTACK_HOST_IP)%:5000 \
--os-project-name $(OPENSTACK_ADMIN_TENANT) \
--murano-url http://$(MURANO_IP):8082 \
package-import --is-public *.zip
rm *.zip
