#!/bin/bash



source ~/keystonerc_admin

openstack service create --name murano --description \
"Application Catalog for OpenStack" application-catalog

##MURANO_SERVICE_ID

openstack endpoint create --region RegionOne --publicurl http://127.0.0.1:8082/ \
--adminurl http://127.0.0.1:8082/ --internalurl http://127.0.0.1:8082/ \
%MURANO_SERVICE_ID%



#Fills the application catalog
cd ~/murano

git clone git://git.openstack.org/openstack/murano-apps

git clone git://git.openstack.org/openstack/k8s-docker-suite-app-murano.git

cd ~/murano/murano


##AVAILABLE APPLICATIONS:
#Crate      Elasticsearch  Grafana    HTTPdServer  InfluxDB  Jenkins  MongoDB  Nginx      Orion       Redis
#DockerApp  GlassFish      GuestBook  HTTPdSite    JBoss     MariaDB  MySQL    NginxSite  PostgreSQL  Tomcat
## 

#pushd ../murano-apps/Docker/Applications/%APP-NAME%/package
pushd ../k8s-docker-suite-app-murano/Applications/

zip -r ~/murano/murano/DockerApp.zip *
popd
tox -e venv -- murano --murano-url http:127.0.01:8082 package-import DockerApp.zip