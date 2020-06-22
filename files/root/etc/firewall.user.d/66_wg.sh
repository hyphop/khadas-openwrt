## accept wg

iptables -I FORWARD -i wg+ -j ACCEPT
iptables -I FORWARD -o wg+ -j ACCEPT
iptables -t nat -I POSTROUTING -o wg+ -jMASQUERADE
iptables -t mangle -A FORWARD -o wg+ -p tcp -m tcp \
    --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu


