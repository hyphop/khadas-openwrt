#!/bin/sh

## hyphop ##

#= rc.local.d script

logger -t "$0" "$@"

## wifi hacks
LOG=/tmp/wifi_fix1.log
/opt/wifi_fix1 1>$LOG 2>&1 &
