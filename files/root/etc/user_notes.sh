#!/bin/sh

## hyphop ##

#= user_notes

LAN_IP="$(uci get network.lan.ipaddr)"
WAN_IP="$(ipaddr eth0)"

APID=$(pgrep avahi)
[ "$APID" ] && {
M=$(cat /proc/$APID/cmdline)
M=${M#*[}
M=${M%]*}
MDNS="$M"
}

TTYIP=$LAN_IP
[ "$MDNS" ] && TTYIP=$MDNS

for TPID in $(pgrep ttyd); do

M="$(cat /proc/$TPID/cmdline)"

case "$M" in
    *login*)
    M=${M#*-p}
    M=${M%%login*}
    TTYD="WEB TERM: http://$TTYIP:$M/"
    ;;
esac
done

echo "[i] LAN_IP: $LAN_IP WAN_IP: $WAN_IP MDNS: $MDNS
WEB : http://$TTYIP $TTYD"
#echo "[i] router gw: GW=$(ip route show default)"

