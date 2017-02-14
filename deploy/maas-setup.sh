#/bin/bash
set -e
set -x
APIKEY=`sudo maas-region-admin apikey --username admin`
maas login root http://127.0.0.1/MAAS/api/1.0 ${APIKEY}
maas root boot-source-selections create 1 os="ubuntu" release="xenial" arches="amd64" subarches="*" labels='*'
sleep 20s
maas root node-groups import-boot-images
maas root boot-resources import
UUID=`maas root node-groups list |grep uuid | awk '{print $2}' | sed -e 's/"//g'`
maas root node-group-interface update ${UUID} eth1 ip_range_high=192.168.50.200 ip_range_low=192.168.50.100 management=2 broadcast_ip=192.168.50.255 router_ip=192.168.50.99
echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
/sbin/iptables -t nat -A POSTROUTING -s 192.168.50.0/255.255.255.0 -j MASQUERADE
