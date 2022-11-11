# OpenStack-deployment of 5G networking

Installation, deployment and few config scripts for few OpenStack services. 

Tested only on CentOS7.

## 2. Installment

TLWR: Steps:

1. Install CentOS7 image to the machine via ./install.sh script, local is recommended.
2. Run ./key_generate.sh to create key-pairs which will be used at 5g components.
3. Run ./net_init.sh, ./networking_5g.sh to create networks. Run ./security_groups to allow SSH and HTTPS.
4. Run ./boot_instances to create 5g network. 
5. Run ./attach_interfaces.sh to bind created network interfaces with components.
6. Run ./modify_instances.sh to do the nasty networking stuff for you. 
7. Run ./net_delete.sh and ./remove_5g.sh to rollback the deployment.

At very first step, it should be known that if hardware supports virtualization and enabled in BIOS settings. For Linux based systems, `lscpu` command helps to find out virtualization technology, also `grep --color vmx /proc/cpuinfo`  indicates if you have one of usual types. 

The environment might provide limited performance for virtualization.  In order to see, you can run `virt-host-validate` command. If you see something like first image and want to launch several 'official cloud Ubuntu' images you may consider having your OpenStack server in different VM host capable for sufficient nested virtualization or on a physical machine(bare metal) instead of virtual machine. Still, it is possible to set OpenStack on VM host and do proof of concept with cirros images.

*** If the Openstack needs to be hosted on a VM, part 1.2 should be taken into consideration in order to overcome the 'nested virtualization' issue. 

After checking virtualization feasibility, one can move to installation. OpenStack consists of co-work of several services like Neutron for networking, Nova for life-cycle events of VMs, Glance for images usw. The services either can be distributed on different nodes or all can be in one node. The instructions follows for  allinone installation of OpenStack services at CentOS7 on physical machine. It is recommended to use CentOS7 for OpenStack setup also make use of `packstack` installer, or for Ubuntu16 devstack can be used. Following instructions should be followed to set server up;

If there is an external(public) network already, do NOT apply step 3 in a) and continue with b). This guide can be followed until creating private network, the rest will be happening via scripts. Or it is possible to examine the install.sh script and use it from setup-open5gcore/openstack repository.

External network and subnet should be created as shown in b). Instances(VMs) will have floating IPs(public) from subnet of the external network, so modify own gateway and available IP pool accordingly. 

a) https://www.rdoproject.org/install/packstack/

b) https://www.rdoproject.org/networking/neutron-with-existing-external-network/

After network restart reated OpenVSwitch bridges can be checked with `ovs-vsctl show | grep br` , if there is an error in options of br-int/ext/tun, you should control interface and bridge configurations.

Below is the nwetworking map you are creating now.
<img width="834" alt="Screenshot 2022-10-16 at 16 59 36" src="https://user-images.githubusercontent.com/25350481/196042868-aa738523-317d-4d1a-bfab-6c26d6c44de7.png">

Subnets and internal/external network should look like:
<img width="846" alt="Screenshot 2022-10-16 at 16 59 57" src="https://user-images.githubusercontent.com/25350481/196042914-85a2cbe4-31a8-498e-b3d5-44df50cd4cc5.png">

Tunnel interfaces:
<img width="407" alt="Screenshot 2022-10-16 at 16 59 28" src="https://user-images.githubusercontent.com/25350481/196042951-3e92b5f5-a69d-426c-b809-7b218e414389.png">

After logging into OpenStack dashboard (credentials provided in ~/keystonerc_admin file), first thing to do is adding SSH key to Project->Compute-> Key Pairs , since the instances will be using this key with a given name. And following, is to allow SSH(22) on port rules under Project->Network->Security Groups. Also by default OpenStack only allows outgoing traffic, not incoming traffic, this should be (can be for any protocol) enabled as well. 

Check once in a while to see available flavors and use wisely.
<img width="405" alt="Screenshot 2022-10-16 at 17 00 11" src="https://user-images.githubusercontent.com/25350481/196043039-021553c3-11f4-42fd-b563-d8b9fa66847d.png">

Port bindings(security groups) for additional components.
<img width="387" alt="Screenshot 2022-10-16 at 17 00 21" src="https://user-images.githubusercontent.com/25350481/196043068-8b5d5f60-210e-4401-a521-99ed115dc429.png">

### 1.2 Installment on VM

It is again recommended to make the installation on a CentOS7 VM, for the limitation concerns you may prefer begin choose install the 'Minimal Server' and install the requirements manually. For less troubleshooting CentOS also offers 'virtualization host' option as booting phase. 

If OpenStack is already installed on the server, it is not required to install it again. But make sure, that your setup has no other issue(i.e checking logs at  */var/log/nova/* or */var/log/neutron*. 

Nested virtualization prevents to launch VMs in OpenStack, and further steps should be done to accomplish.   

First, check if the OS supports the virtualization by '`lscpu`', it should  print the virtualization type as full and a Hypervisor vendor (i.e KVM). Then check if libvirtd is active and running ( i.e systemctl status libvirtd). 

Based on the OS type, kvm and libvirtd might be not installed. So, get it i.e;

`yum install qemu-kvm qemu-img  libvirt libvirt-python libvirt-client virt-install virt-viewer bridge-utils
`

`yum info libvirt`

`yum info kvm`

If everything seems correct;

`service libvirtd restart`


Next, edit the file */etc/modprobe.d/kvm.conf* (for KVM based virtualization) as;

`options kvm_intel nested=1`

and check for the hypervisor: `virsh capabilities | grep kvm`

as last: edit `/etc/sysctl.conf` 

net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-arptables = 1

and reload as `sudo sysctl -p /etc/sysctl.conf` and `sudo service libvirtd reload`


## 2. Networking

As it explained in b), to use service commands provided by OpenStack, the '~/keystonerc_admin' file should be sourced as in following script. Most of the tasks can be handled through OpenStack dashboard but CLI provides better capability and efficiency.

Network configuration is handled with the `/Open5GCore/openstack/networking_5g.sh`  [*]script which creates first interfaces and subnets, later creating ports to for the be attached instances on boot phase. 'mgmt' network is used for signalling backhaul, 'net_a' and 'net_b' for IP Services Network, 'net_c' for subscriber IP range and 'net_d' operates as RAN backhaul and “access” interface for the reachability to the instances over SSH. The IP addresses are based on 
> /Open5GCore/setups/commons/custom/open5gcore.zone 

Script creates network interfaces, router and related ports with fixed IP addresses for defined instances. 

Consequently after script, created networks should look similar.Floating IPs are obtained from the subnet of external network and assigned after booting the instances. If the IP pool is limited, by associating even one floating IP to any instance and reaching others through SSH is also possible.

## 3. Deployment

First step of deployment is uploading image file in stack. This can be done with an existing image or plain official cloud images. With next command, we are uploading a image which will be base for 5G components, `openstack image create --public --disk-format qcow2 --container-format bare --file /opt/5GCore_image.qcow2 5G_core_image`. This image has phoenix and requirements installed and can make things easier but at this step a plain image(Ubuntu16 is recommended) can also be used. In this case, requirements can be installed on this image and snapshot of this image can be created and other instances can be deployed from this snapshot image.

Flavors are the memory and storage definitions of instances. In order to utilize sources more efficient, OpenStack enables to create custom flavors. For the 5G components, it is recommended to have at least 2GB memory and 15GB storage, Existing flavors can be seen with `openstack flavor list` and creation i.e; 
`openstack flavor create --ram 2048 --disk 20 --ephemeral 0 --vcpus 1 --id 7 t.small`

On booting phase, network, image, flavor, key pair information is combined in `/openstack/boot_instances_5g.sh`

script to launch instances. File scans IDs of previously defined ports and uses them as booting. If you have subnet names different than in script, you may require to edit script. This is certainly valid for the `--key-name` and flavor name ,the last argument defines the name of the instance which should be exact since it will be needed in modify_instance.sh script. If additional interfaces are required, these can be added via attach_interfaces_5g.sh script to an active instance.

At the end the instance list is shown and the instance states should be active and running. If a problem occurs log files(part 5) should be investigated.

## 4. Configuration

Once the instances are ready and correct key is assigned on boot phase, it should be possible to access them through SSH as default user ubuntu. To do so, at least one instance needs to have floating IP which first should be allocated for the project under Project->Network->Floating IPs->Allocate IP to Project then IP can be associated to the instance. 

At this step, we are about to run;

> `openstack/modify_instances.sh` 

script and it is important that the names of the instances in OpenStack are matching within conditional statements(hostname) in script. Modifications target mostly network configurations as adding interfaces with their names and to device manager rules. After running script reboot is required then check/restart your service network. Configured interfaces can be checked with `ifconfig` and in `/etc/network/interfaces` and interfaces should have added to `/etc/udev/rules.d/70-persistent-net.rules`. The incoming and outgoing traffic should be open and working.  

Second step is to run; 

> `setups/configure_system_old.sh` 

script, which configures the instance for the required node setup. It should be run as sudo to overcome file permission issues.
Script modifies the interfaces file and ethernet interface for 'access' network will be missing, the below should be added to file. 

> auto ens3
> iface ens3 inet dhcp

Once instances booted, and power states are active, floating IP can be assigned to the instance. After adding  private key to the SSH agent, can log in to the instance over floating IP, and it would be possible to log in other instances via same key and through 'access' network IPs.  

## 5. Logs & Troubleshooting

To see server utilisation and faulty statements, the main places to check;

* `/var/log/nova/nova-compute.log` 
* `/var/log/nova/nova-scheduler.log` 
* `/var/log/neutron/server.log`

Below commands can be used to restart services. Remember to source the 'keystonerc_admin' file. 

>  Compute services 

* `service openstack-nova-api restart`
* `service openstack-nova-cert restart`
* `service openstack-nova-consoleauth restart`
* `service openstack-nova-scheduler restart`
* `service openstack-nova-conductor restart`
* `service openstack-nova-novncproxy restart`

>  Networking services 

* `service neutron-server restart`
* `service neutron-dhcp-agent restart`
* `service neutron-l3-agnet restart`
* `service neutron-metadata-agent restart`
* `service neutron-openvswitch-agent restart`

>  Storage services 

* `service openstack-cinder-api restart`
* `service openstack-cinder-backup restart`
* `service openstack-cinder-scheduler restart`
* `service openstack-cinder-volume restart`




Additionally, use Jenkins/Ansible/Gitlab to create CI/CD pipeline.

Related research paper: https://www.researchgate.net/publication/325381449_Cloud_deployment_continuous_integration_of_5G-CogNet_components
