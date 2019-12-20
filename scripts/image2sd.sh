#!/bin/sh

## hyphop ##

#= simple command line image writer

##
## write compressed images on the fly
## supported raw | gz | 7z | zip formats
##

USAGE(){ echo "image2sd.sh - simple commant line image writer
    write raw or gz|zip|7z|...-packed image on the fly without repack

USAGE

image2sd.sh IMAGE [DEV] [-p]

    IMAGE - file.[gz|zip|7z|img]
    DEV   - /dev/mmcblk? or /dev/sdx
    -p    - bypass part table
    -a 	  - auto detect sd card 
    -no	  - no auto detect sd card 

AUTHOR

    ## hyphop ##
"
}

uid=$(id -u)
gid=$(id -g)

sudo=sudo

[ "$uid" = "0" ] && sudo=
[ "$gid" = "0" ] && sudo=

#echo "[i] UID: $uid GID: $gid SUDO: $sudo">&2

SAVE_PT=

[ "$1" ] || {
    USAGE
    exit 1
}


AUTO=

#IN=
#SD=

for a in "$@"; do

    case $a in
    -p)
    SAVE_PT=1
    continue
    ;;
    -a)
    AUTO=1
    continue
    ;;
    -an|-no)
    AUTO=
    continue
    ;;
    -h|--help)
    USAGE
    exit 0
    ;;
    esac

    [ -b "$a" ] && {
	SD="$a"
    }
    [ -f "$a" ] && {
	IN="$a"
    }

done

[ "$SD" ] || {
[ "$AUTO" ] && {
for t in \
    /sys/class/block/mmc*/device/type \
    /sys/class/block/*/device/model; \
    do
    [ -f $t ] && {
    d=${t#*block/}
    d=${d%%/*}
    egrep -q "Card|^SD" $t && {
    SD=/dev/$d
    echo "[i] auto detected dev: $SD ($(cat $t))">&2
    break
    }
    }
done
}
}

[ "$SD" ] || {
    echo "[e] target device not defined">&2
    exit 1
}

#echo "[i] burn image to $SD">&2

[ -b $SD ] || {
    echo "[e] not block dev $SD">&2
    exit 1
}

FAIL(){
    echo "[e] $@">&2
    exit 1
}

[ "$IN" ] || {
for i in *.gz *.7z *.zip  ; do
    [ -f "$i" ] && {
	IN="$i"
	break
    }
done
}

[ "$IN" ] || {
    echo "[e] image not defined">&2
    exit 1
}

[ -s "$IN" ] || {
    echo "[e] not found image $IN">&2
    exit 1
}


echo "[i] IMAGE: $IN > $SD">&2

ASK(){
[ "$FORCE" ] || {
    echo "[i] are u sure ? press any key or Ctrl+C for escape">&2
    read l
}
}



ARGS=bs=1M

PTT=/tmp/image2sd.ptt

[ "$SAVE_PT" ] && {
    echo "[i] save part table $SD -> $PTT">&2
#   $sudo dd if=$SD count=1 of=$PTT 1>/dev/null 2>/dev/null || FAIL save parts
    $sudo dd if=$SD count=1 of=$PTT 2>$PTT.log 1>/dev/null || FAIL "save parts $(cat $PTT.log)"
}

case "$IN" in
    *.gz)
    echo "[i] gzip image mode">&2

    S=$(gzip -q -l "$IN" | grep ".img")

    [ "$S" ] || FAIL broken gz

    S=$(echo $S)
    S="${S% *}"
    S="${S% *}"
    S=${S#* }

    [ "$S" ] || {
    echo "[e] broken gzip container">&2
    sleep 2
    exit 1
    }

    echo "[i] write raw image $S bytes to $SD">&2

    echo "# gzip -dc "$IN" | pv -s $S > $SD">&2

    ASK

    gzip -dc "$IN" | pv -s $S | $sudo dd $ARGS of=$SD || FAIL write data
    ;;
    *.xz)
    echo "[i] xz image mode">&2
    ASK
    xz -dc "$IN" | pv | $sudo dd $ARGS of=$SD || FAIL write data
    ;;
    *.zip)
    echo "[i] zip image mode">&2
    unzip -l "$IN" "*.img" || FAIL wrong zip
    S=$(unzip -l "$IN" | grep ".img" | tail -1)
    S=$(echo $S)
    S=${S%% *}

    echo "[i] write raw image $S bytes to $SD">&2

    ASK

    unzip -p "$IN" "*.img" | pv -s $S | $sudo dd $ARGS of=$SD || FAIL write data

    ;;
    *.7z)
    echo "[i] 7z image mode">&2
    IMG_DATA=$(7z l "$IN" | grep -m1 .img)
    IMG=${IMG_DATA##* }
    IMG_SIZE=${IMG_DATA% *}
    IMG_SIZE=$(echo $IMG_SIZE)
    IMG_SIZE=${IMG_SIZE% *}
    S=${IMG_SIZE##* }
    echo "[i] write $S bytes of $IMG">&2

    ASK

    7z x "$IN" "$IMG" -so | pv -s $S | $sudo dd $ARGS of=$SD

    ;;
    *)
    echo "[i] raw image mode">&2

    ASK

    pv "$IN" | $sudo dd $ARGS bs=1M of=$SD || FAIL write data
esac

[ "$SAVE_PT" ] && {
    echo "[i] restore part table">&2
    $sudo dd if=$SD count=1 conv=fsync,notrunc bs=444 of=$PTT 	1>/dev/null 2>$PTT.log || FAIL "restore parts $(cat $PTT.log)"
    $sudo dd of=$SD count=1 conv=fsync,notrunc if=$PTT		1>/dev/null 2>$PTT.log || FAIL "restore parts $(cat $PTT.log)"
    sync
    echo "[i] refresh part tables">&2
    echo "w\nq\n" | $sudo fdisk $SD 1>/dev/null 2>/dev/null

}

sync

echo "[i] DONE"
