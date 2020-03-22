## accept pptp vpn

iptables -I INPUT -p tcp -m tcp --sport 1723 -j ACCEPT
iptables -I INPUT -p gre -j ACCEPT

