# openstack-deployment

Installation, deployment and few config scripts for few OpenStack services. 

Tested only on CentOS7.


Steps:

1. Install CentOS7 image to the machine via ./install.sh script, local is recommended.
2. Run ./key_generate.sh to create key-pairs which will be used at 5g components.
3. Run ./net_init.sh, ./networking_5g.sh to create networks. Run ./security_groups to allow SSH and HTTPS.
4. Run ./boot_instances to create 5g network. 
5. Run ./attach_interfaces.sh to bind created network interfaces with components.
6. Run ./modify_instances.sh to do the nasty networking stuff for you. 
7. Run ./net_delete.sh and ./remove_5g.sh to rollback the deployment.


Additionally, use Jenkins/Ansible/Gitlab trio to create CI/CD pipeline.



Related research paper: https://www.researchgate.net/publication/325381449_Cloud_deployment_continuous_integration_of_5G-CogNet_components
