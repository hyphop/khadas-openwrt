## nfs

iptables -I INPUT -j ACCEPT -i eth0 -p tcp --dport 111
iptables -I INPUT -j ACCEPT -i eth0 -p udp --dport 111
iptables -I INPUT -j ACCEPT -i eth0 -p tcp --dport 32777:32780
iptables -I INPUT -j ACCEPT -i eth0 -p udp --dport 32777:32780
iptables -I INPUT -j ACCEPT -i eth0 -p tcp --dport 2049
iptables -I INPUT -j ACCEPT -i eth0 -p udp --dport 2049
