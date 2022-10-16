# OpenStack-deployment of 5G networking

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

Below is the nwetworking map you are creating now.
<img width="834" alt="Screenshot 2022-10-16 at 16 59 36" src="https://user-images.githubusercontent.com/25350481/196042868-aa738523-317d-4d1a-bfab-6c26d6c44de7.png">

Subnets and internal/external network should look like:
<img width="846" alt="Screenshot 2022-10-16 at 16 59 57" src="https://user-images.githubusercontent.com/25350481/196042914-85a2cbe4-31a8-498e-b3d5-44df50cd4cc5.png">

Tunnel interfaces:
<img width="407" alt="Screenshot 2022-10-16 at 16 59 28" src="https://user-images.githubusercontent.com/25350481/196042951-3e92b5f5-a69d-426c-b809-7b218e414389.png">


Check once in a while to see available flavors and use wisely.
<img width="405" alt="Screenshot 2022-10-16 at 17 00 11" src="https://user-images.githubusercontent.com/25350481/196043039-021553c3-11f4-42fd-b563-d8b9fa66847d.png">


Port bindings(security groups) for additional components.
<img width="387" alt="Screenshot 2022-10-16 at 17 00 21" src="https://user-images.githubusercontent.com/25350481/196043068-8b5d5f60-210e-4401-a521-99ed115dc429.png">



Related research paper: https://www.researchgate.net/publication/325381449_Cloud_deployment_continuous_integration_of_5G-CogNet_components
