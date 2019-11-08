#!/bin/sh

## hyphop ##

## display post config setup

UPTIME=$(cat /proc/uptime)
UPTIME=${UPTIME% *}

[ -f /tmp/uptime.boot ] || {
echo $UPTIME > /tmp/uptime.boot
}

INFO="[i] POST_CONFIG: "

for a in $(cat /proc/cmdline); do
    case $a in
    booted*|hwver*|eth_*|ap_*|wifi_*|pass*|hostname*|script*)
	INFO="$INFO $a"
    ;;
    esac
done


echo "$INFO"
echo "[i] BOOTINFO: uptime: $UPTIME sec,  bootup: $(cat /tmp/uptime.boot)"