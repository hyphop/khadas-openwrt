#!/bin/sh

## hyphop ##

#= make xz

D=$(dirname $0)

. $D/make_

PKG=xz-5.2.4.tar.gz

echo "[i] make $PKG">&2

../download https://tukaani.org/xz/$PKG $PKG $DL || exit 1

cd $DL

D=${PKG%.tar.*}

[ -d "$D" ] || \
    tar -xf $PKG

cd $D

export LT_SYS_LIBRARY_PATH=$PRE2/lib
export LDFLAGS="-L$PRE2/lib -Wl,-rpath=$PRE2/lib"

make clean

./configure --prefix="$PRE2"  && \
    make $MAKE_MT && \
	make install
