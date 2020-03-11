#!/bin/sh

## hyphop ##

#= make squashfs-tools

D=$(dirname $0)

. $D/make_

VER=4.4
NAME=squashfs-tools
PKG=$NAME-$VER.tar.gz

echo "[i] make $PKG">&2

../download https://github.com/plougher/squashfs-tools/archive/$VER.tar.gz $PKG $DL || exit 1

cd $DL

D=${PKG%.tar.*}

[ -d $D ] || \
    tar -xf $PKG

cd $D
cd $NAME

export EXTRA_CFLAGS="-I$PRE2/include"
export EXTRA_LDFLAGS="-L$PRE2/lib -Wl,-rpath=$PRE2/lib"

make clean

make $MAKE_MT XZ_SUPPORT=1 ZSTD_SUPPORT=1 mksquashfs unsquashfs && \
    cp mksquashfs unsquashfs $PRE2/bin


