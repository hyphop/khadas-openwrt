#!/bin/sh

## hyphop ##

#= rc.local.d script

logger -t "$0" "$@"

pgrep dbus || {
    /etc/init.d/dbus start
}

/etc/init.d/avahi-daemon restart
