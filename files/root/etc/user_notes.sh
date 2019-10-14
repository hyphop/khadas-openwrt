#!/bin/sh

## hyphop ##

#= user_notes
echo "[i] LAN_IP: $(uci get network.lan.ipaddr) WAN_IP: $(ipaddr eth0)"
#echo "[i] router gw: GW=$(ip route show default)"

