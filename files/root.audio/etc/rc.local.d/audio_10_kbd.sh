#!/bin/sh

## hyphop 

#= custom audio start script

CMD(){
    echo "[#] $@">&2
    $@
}

CMD /etc/init.d/triggerhappy stop


	SOCKET=/tmp/triggerhappy.kbd.mpd.socket

	CMD pkill -f $SOCKET

	CMD thd --socket $SOCKET \
	    --triggers /etc/triggerhappy/triggers.d/*kbd*.conf \
	    --daemon /dev/input/*
