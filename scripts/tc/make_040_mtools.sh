#!/bin/sh

## hyphop ##

#= make mtools

D=$(dirname $0)

. $D/make_

VER=4.0.23
NAME=mtools
PKG=$NAME-$VER.tar.gz

echo "[i] make $PKG">&2

../download ftp://ftp.gnu.org/gnu/mtools/$PKG $PKG $DL || exit 1

cd $DL

D=${PKG%.tar.*}

[ -d $D ] || \
    tar -xf $PKG

cd $D

./configure --prefix="$PRE2"

#export EXTRA_CFLAGS="-I$PRE2/include"
#export EXTRA_LDFLAGS="-L$PRE2/lib -Wl,-rpath=$PRE2/lib"

#make clean

make $MAKE_MT && \
    cp mtools mcopy -a $PRE2/bin
    


