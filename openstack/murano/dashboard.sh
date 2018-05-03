#!/bin/bash

cd ~/murano

git clone git://git.openstack.org/openstack/murano-dashboard

git clone git://git.openstack.org/openstack/horizon

cd horizon
tox -e venv -- pip install -e ../murano-dashboard

cp openstack_dashboard/local/local_settings.py.example \
openstack_dashboard/local/local_settings.py

cp ../murano-dashboard/muranodashboard/local/enabled/*.py \
openstack_dashboard/local/enabled/

cp ../murano-dashboard/muranodashboard/local/local_settings.d/*.py \
openstack_dashboard/local/local_settings.d/

cp ../murano-dashboard/muranodashboard/conf/* openstack_dashboard/conf/

cp ../murano-dashboard/muranodashboard/local/_50_murano.py \
openstack_dashboard/local/enabled/

######
# vim openstack_dashboard/local/local_settings.py
######

#Django server
tox -e venv -- python manage.py runserver 127.0.0.1:8000