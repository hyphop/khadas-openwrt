#!/bin/sh

## hyphop ##

#= write uboot to disk

#[ "$DEV" ] || DEV=/dev/mmcblk0

UBOOT=
DEV=

FORCE=
for a in "$@"; do
    case $a in

    -f)
    FORCE=1
    ;;

    *.bin)
    [ -f "$a" ] && {
	UBOOT=$a
    }
    ;;
    /dev/*)
    [ -b $a ] && {
	DEV=$a
    }
    ;;
    esac
done

sudo=sudo

[ "$UBOOT" ] || {
    echo "[e] undef UBOOT ">&2
    exit 1
}

[ "$DEV" ] || {
    echo "[e] undef block DEV">&2
    exit 1
}

DEVNAME=$(cat /sys/class/block/${DEV#/dev/}/device/model)

echo "[i] wite u-boot $UBOOT to dev $DEV ($DEVNAME)">&2


CMD(){
    echo "[#] $@">&2
    "$@"
}

[ "$FORCE" ] || {
    echo "[i] are u sure ? press any key or Ctrl+C for escape">&2
    read l
}

#exit 1

echo "[i] OK burn it ;)">&2
#sleep 1

CMD $sudo dd if=$UBOOT of=$DEV conv=fsync,notrunc bs=444 count=1
CMD $sudo dd if=$UBOOT of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1

sync
