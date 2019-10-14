#!/bin/sh

## hyphop ##

#=  ss proxy

## CONFIG BEGIN

[ $SERVER ] || SERVER=
[ $PORT ] || PORT=5500
[ $PASS ] || PASS=

[ "$CRYPT" ] || CRYPT=rc4-md5

##

SA=123.123.123.123
SP=1234

## CONFIG END


CMD(){
    echo "$@"
    $@
}

iptables_remove() {
iptables -t nat -F SHADOWSOCKS
iptables -t mangle -F SHADOWSOCKS
iptables -t nat -D PREROUTING -p tcp -j SHADOWSOCKS
iptables -t mangle -D PREROUTING -j SHADOWSOCKS
}

iptables_setup() {
# Create new chain
iptables -t nat -N SHADOWSOCKS
iptables -t mangle -N SHADOWSOCKS
# Ignore your shadowsocks server's addresses
# It's very IMPORTANT, just be careful.
iptables -t nat -A SHADOWSOCKS -d $SA -j RETURN
# Ignore LANs and any other addresses you'd like to bypass the proxy
# See Wikipedia and RFC5735 for full list of reserved networks.
# See ashi009/bestroutetb for a highly optimized CHN route list.
iptables -t nat -A SHADOWSOCKS -d 0.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 10.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 127.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 169.254.0.0/16 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 172.16.0.0/12 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 192.168.0.0/16 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 224.0.0.0/4 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 240.0.0.0/4 -j RETURN

# Anything else should be redirected to shadowsocks's local port
iptables -t nat -A SHADOWSOCKS -p tcp -j REDIRECT --to-ports $SP
# Add any UDP rules

ip route add local default dev lo table 100
ip rule add fwmark 1 lookup 100
iptables -t mangle -A SHADOWSOCKS -p udp --dport 53 -j TPROXY --on-port $SP --tproxy-mark 0x01/0x01

# Apply the rules
iptables -t nat -A PREROUTING -p tcp -j SHADOWSOCKS
iptables -t mangle -A PREROUTING -j SHADOWSOCKS
# Start the shadowsocks-redir
#ss-redir -u -c /etc/config/shadowsocks.json -f /var/run/shadowsocks.pid

}
#ifconfig lo:1 $SA

#-b $SA

    iptables_remove


[ "$SERVER" ] || {
    echo "[i] $0 SERVER not defined $SERVER">&2
    exit 1
}

[ "$PORT" ] || {
    echo "[i] $0 PORT not defined $PORT">&2
    exit 1
}

[ "$PASS" ] || {
    echo "[i] $0 PASS not defined $PASS">&2
    exit 1
}

[ "$CRYPT" ] || {
    echo "[i] $0 CRYPT not defined $CRYPT">&2
    exit 1
}


for a in $@; do

    case $a in

	--kill|--stop)
	echo "[i] stop ">&2
	pkill -f ss-redir
	exit 0
	;;
	*)
	echo "[i] parse $a"
	;;

    esac

done

    iptables_setup

CMD ss-redir -s $SERVER \
    -p $PORT \
    -l $SP \
    -b 0.0.0.0 \
    -u \
    -m $CRYPT \
    -k $PASS \
    --reuse-port --fast-open --no-delay -f /var/log/ss.proxy.pid && {
    echo "[i] OK end">&2
#    iptables_setup

}

echo "[e] oooops">&2

#    iptables_remove

