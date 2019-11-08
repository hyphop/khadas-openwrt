#!/bin/sh

## hyphop ##

# simple build

f=usc

cd $(dirname $0)

path=../../../../tc/bin/

[ -d bin ] || mkdir bin

pref=aarch64-openwrt-linux-

export STAGING_DIR=$PWD/../path

#bin=

#[ "$1" = "" ] || {
    bin="$path$pref"
#}

gcc=${bin}gcc
strip=${bin}strip

cmd="$gcc $f.c -o bin/$f"
echo $cmd
$cmd
cmd="$strip bin/$f"
echo $cmd
$cmd
