#!/bin/sh

## hyphop ##

#= automount action script

ACTION="$1"
LOCATION="$2"

N=$(basename $LOCATION)


export USER=root
export LD_LIBRARY_PATH=/tmp/lib:/tmp/usr/lib:/lib:/usr/lib:
export HOME=/root
export LOGNAME=root
export PATH=/opt:/tmp/opt:/usr/sbin:/usr/bin:/sbin:/bin
export SHELL=/bin/ash


case $ACTION in
    add)
	echo "[i] $0 update mpd $N"
	( mpc --wait update && mpd_playall
	) &
    ;;
    remove)

	mpc -f %file% | grep "$N" && {
	echo "[i] $0 fix mpd status $N"

	mpc --wait stop
	sleep 1

	}
    ;;
    *)
    ;;
esac

