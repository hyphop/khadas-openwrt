## mdns

iptables -I INPUT -p udp -m udp --sport 5353 -j ACCEPT
iptables -I OUTPUT -p udp -m udp --dport 5353 -j ACCEPT
iptables -I FORWARD -p udp -m udp --sport 5353 -j ACCEPT
iptables -I FORWARD -p udp -m udp --dport 5353 -j ACCEPT

