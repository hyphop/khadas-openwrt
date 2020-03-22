# redirect all to local 53 resolver

iptables -t nat -A PREROUTING -i br-lan ! -d 172.23.0.1 -p udp --dport 53 -j REDIRECT --to-ports 53
