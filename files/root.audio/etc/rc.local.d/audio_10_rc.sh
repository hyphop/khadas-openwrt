#!/bin/sh

## hyphop 

#= custom audio start script

rc_on

CMD(){
    echo "[#] $@">&2
    $@
}

CMD /etc/init.d/triggerhappy stop

for i in /sys/class/input/event?; do

    n=${i##*/}
    name=$(cat $i/device/name)
    dev=/dev/input/$n

    grep -q meson-ir $i/device/name && {
        echo "[i] $name => $dev"

	SOCKET=/tmp/triggerhappy.$name.mpd.socket

	CMD pkill -f $SOCKET

	CMD thd --socket $SOCKET \
	    --triggers /etc/triggerhappy/triggers.d/*rc*.conf \
	    --daemon $dev

    }

done


#/opt/mpd2airplay 2>&1 >> /tmp/mpd2.log

#[ -d /sys/module/snd_usb_audio ] || modprobe snd_usb_audio

#mpd

