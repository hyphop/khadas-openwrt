#!/bin/sh

## hyphop ##

## display post config setup

INFO="[i] POST_CONFIG: "

for a in $(cat /proc/cmdline); do
    case $a in
    booted*|hwver*|eth_*|ap_*|wifi_*|pass*|hostname*|script*)
	INFO="$INFO $a"
    ;;
    esac
done

echo "$INFO"
