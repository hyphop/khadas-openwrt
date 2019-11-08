#!/bin/sh

## hyphop 

#= custom audio start script

[ -d /sys/module/snd_aloop ] || {
    modprobe snd_aloop
    #LOOP=-f alsa default:CARD=Loopback
}

