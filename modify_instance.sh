#!/bin/bash
#
#Script gets names and MAC addresses of interfaces and adds them into interfaces and udev device manager.

host=$(hostname)
$(sudo chown ubuntu /etc/hosts)

name=$(printf '127.0.0.1 localhost localhost.localdomain %s' "$host")
echo $name > /etc/hosts

$(sudo chown ubuntu /etc/udev/rules.d/70-persistent-net.rules)
$(sudo chown ubuntu /etc/network/interfaces.d/50-cloud-init.cfg)


echo -e "\n# The following lines are desirable for IPv6 capable hosts
::1 ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
ff02::3 ip6-allhosts" >> /etc/hosts



wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt-get update --fix-missing
sudo apt-get upgrade
sudo apt-get install bind9 bind9utils bind9-doc
sudo apt-get install zabbix-agent


mac_1=$(ifconfig -a | grep -Po 'HWaddr \K.*$' | sed -n -e '1{p;q}')
mac_2=$(ifconfig -a | grep -Po 'HWaddr \K.*$' | sed -n -e '2{p;q}')
mac_3=$(ifconfig -a | grep -Po 'HWaddr \K.*$' | sed -n -e '3{p;q}')
mac_4=$(ifconfig -a | grep -Po 'HWaddr \K.*$' | sed -n -e '4{p;q}')
mac_5=$(ifconfig -a | grep -Po 'HWaddr \K.*$' | sed -n -e '5{p;q}')
mac_6=$(ifconfig -a | grep -Po 'HWaddr \K.*$' | sed -n -e '6{p;q}')

iface_1=$(ifconfig -a | cut -c1-8 | sort | uniq -u | sed -n -e '1{p;q}')
iface_2=$(ifconfig -a | cut -c1-8 | sort | uniq -u | sed -n -e '2{p;q}')
iface_3=$(ifconfig -a | cut -c1-8 | sort | uniq -u | sed -n -e '3{p;q}')
iface_4=$(ifconfig -a | cut -c1-8 | sort | uniq -u | sed -n -e '4{p;q}')
iface_5=$(ifconfig -a | cut -c1-8 | sort | uniq -u | sed -n -e '5{p;q}')
iface_6=$(ifconfig -a | cut -c1-8 | sort | uniq -u | sed -n -e '6{p;q}')

cfg_mgmt=$'\nauto mgmt\niface mgmt inet dhcp'
cfg_net_a=$'\nauto net_a\niface net_a inet dhcp'
cfg_net_b=$'\nauto net_b\niface net_b inet dhcp'
cfg_net_c=$'\nauto net_c\niface net_c inet dhcp'
cfg_net_d=$'\nauto net_d\niface net_d inet dhcp'


if [ $host == 'base' ]
then
	
       
        rule_mgmt=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s" ' "${mac_2:0:17}" "mgmt")
        rule_net_a=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s" ' "${mac_3:0:17}" "net_a")
        rule_net_b=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s" ' "${mac_4:0:17}" "net_b")
        rule_net_c=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s" ' "${mac_5:0:17}" "net_c")
        rule_net_d=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s" ' "${mac_6:0:17}" "net_d")
        
        echo $rule_mgmt >> /etc/udev/rules.d/70-persistent-net.rules
        echo $rule_net_a >> /etc/udev/rules.d/70-persistent-net.rules
        echo $rule_net_b >> /etc/udev/rules.d/70-persistent-net.rules
        echo $rule_net_c >> /etc/udev/rules.d/70-persistent-net.rules
        echo $rule_net_d >> /etc/udev/rules.d/70-persistent-net.rules

        echo "$cfg_mgmt" >> /etc/network/interfaces.d/50-cloud-init.cfg 
        echo "$cfg_net_a" >> /etc/network/interfaces.d/50-cloud-init.cfg 
        echo "$cfg_net_b" >> /etc/network/interfaces.d/50-cloud-init.cfg 
        echo "$cfg_net_c" >> /etc/network/interfaces.d/50-cloud-init.cfg 
        echo "$cfg_net_d" >> /etc/network/interfaces.d/50-cloud-init.cfg 

        
elif [ $host == 'inet-gw' ]
then
        rule_mgmt=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s" ' "${mac_2:0:17}" "mgmt")
        rule_net_a=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s" ' "${mac_3:0:17}" "net_a")
        
        echo $rule_mgmt >> /etc/udev/rules.d/70-persistent-net.rules
        echo $rule_net_a >> /etc/udev/rules.d/70-persistent-net.rules
        echo "$cfg_mgmt" >> /etc/network/interfaces.d/50-cloud-init.cfg 
        echo "$cfg_net_a" >> /etc/network/interfaces.d/50-cloud-init.cfg 


elif [ $host == 'mme1' ]
then
        rule_mgmt=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s" ' "${mac_2:0:17}" "mgmt")
        rule_net_d=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s" ' "${mac_3:0:17}" "net_d")

        echo $rule_mgmt >> /etc/udev/rules.d/70-persistent-net.rules
        echo $rule_net_d >> /etc/udev/rules.d/70-persistent-net.rules
        echo "$cfg_mgmt" >> /etc/network/interfaces.d/50-cloud-init.cfg 
        echo "$cfg_net_d" >> /etc/network/interfaces.d/50-cloud-init.cfg 


elif [ $host == 'mme2' ]
then
        rule_mgmt=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s" ' "${mac_2:0:17}" "mgmt")
        rule_net_d=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s" ' "${mac_3:0:17}" "net_d")

        echo $rule_mgmt >> /etc/udev/rules.d/70-persistent-net.rules
        echo $rule_net_d >> /etc/udev/rules.d/70-persistent-net.rules
        echo "$cfg_mgmt" >> /etc/network/interfaces.d/50-cloud-init.cfg 
        echo "$cfg_net_d" >> /etc/network/interfaces.d/50-cloud-init.cfg 


elif [ $host == 'mme-lb' ]
then
        rule_mgmt=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s" ' "${mac_2:0:17}" "mgmt")
        rule_net_d=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s" ' "${mac_3:0:17}" "net_d")

        echo $rule_mgmt >> /etc/udev/rules.d/70-persistent-net.rules
        echo $rule_net_d >> /etc/udev/rules.d/70-persistent-net.rules
        echo "$cfg_mgmt" >> /etc/network/interfaces.d/50-cloud-init.cfg 
        echo "$cfg_net_d" >> /etc/network/interfaces.d/50-cloud-init.cfg 


elif [ $host == 'hss' ]
then
        rule_mgmt=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s" ' "${mac_2:0:17}" "mgmt")
        
        echo $rule_mgmt >> /etc/udev/rules.d/70-persistent-net.rules
        echo "$cfg_mgmt" >> /etc/network/interfaces.d/50-cloud-init.cfg

elif [ $host == 'bt' ]
then
        rule_mgmt=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s" ' "${mac_2:0:17}" "mgmt")
        rule_net_d=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s" ' "${mac_3:0:17}" "net_d")

        echo $rule_mgmt >> /etc/udev/rules.d/70-persistent-net.rules
        echo $rule_net_d >> /etc/udev/rules.d/70-persistent-net.rules
        echo "$cfg_mgmt" >> /etc/network/interfaces.d/50-cloud-init.cfg 
        echo "$cfg_net_d" >> /etc/network/interfaces.d/50-cloud-init.cfg 


elif [ $host == 'dp-switch1' ]
then
        rule_mgmt=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s"' "${mac_2:0:17}" "mgmt")
        rule_net_a=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s" ' "${mac_3:0:17}" "net_a")
        rule_net_d=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s" ' "${mac_4:0:17}" "net_d")
        
        echo $rule_mgmt >> /etc/udev/rules.d/70-persistent-net.rules
        echo $rule_net_a >> /etc/udev/rules.d/70-persistent-net.rules
        echo $rule_net_d >> /etc/udev/rules.d/70-persistent-net.rules
        echo "$cfg_mgmt" >> /etc/network/interfaces.d/50-cloud-init.cfg 
        echo "$cfg_net_a" >> /etc/network/interfaces.d/50-cloud-init.cfg 
        echo "$cfg_net_d" >> /etc/network/interfaces.d/50-cloud-init.cfg 

elif [ $host == 'pcrf' ]
then
        rule_mgmt=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s"' "${mac_2:0:17}" "mgmt")
        rule_net_a=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s" ' "${mac_3:0:17}" "net_a")
	rule_net_d=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s" ' "${mac_4:0:17}" "net_d")

        echo $rule_mgmt >> /etc/udev/rules.d/70-persistent-net.rules
        echo $rule_net_a >> /etc/udev/rules.d/70-persistent-net.rules
        echo $rule_net_d >> /etc/udev/rules.d/70-persistent-net.rules
	echo "$cfg_mgmt" >> /etc/network/interfaces.d/50-cloud-init.cfg
        echo "$cfg_net_a" >> /etc/network/interfaces.d/50-cloud-init.cfg
	echo "$cfg_net_d" >> /etc/network/interfaces.d/50-cloud-init.cfg

elif [ $host == 'o5gc-gui' ]
then
        rule_mgmt=$(printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", NAME="%s"' "${mac_2:0:17}" "mgmt")

        echo $rule_mgmt >> /etc/udev/rules.d/70-persistent-net.rules
        echo "$cfg_mgmt" >> /etc/network/interfaces.d/50-cloud-init.cfg

else
        echo "Hostname does not match with one of 5G hosts. Either check your hostname and add to /etc/hosts/ file or add rules to script for your machine"
fi

echo -e "\nInterfaces were modified. Reboot instance and compare your interfaces with 'ifconfig' and 'ifconfig -a' commands."
