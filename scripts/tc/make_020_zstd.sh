#!/bin/sh

## hyphop ##

#= make zstd

D=$(dirname $0)
. $D/make_


PA="$DP/patches/zstd"

VER=1.4.4
NAME=zstd
PKG=$NAME-$VER.tar.gz

echo "[i] make $PKG">&2

../download https://github.com/facebook/zstd/releases/download/v$VER/$NAME-$VER.tar.gz || exit 1

cd $DL

D=${PKG%.tar.*}

[ -d $D ] || {
    tar -xf $PKG
}

cd $D

[ -f ".patched" ] || {
    echo "[i] patches">&2
    cat $PA/*.patch | patch -p1 || exit 1
    touch .patched
}

export CFLAGS="-I$PRE2/include"
export LDFLAGS="-L$PRE2/lib -Wl,-rpath=$PRE2/lib"

make clean && \
make $MAKE_MT lib && \
    make install PREFIX="$PRE2"

make $MAKE_MT -C programs zstd-mini && \
make $MAKE_MT -C contrib/pzstd pzstd || exit 1

    cp programs/zstd-mini $PRE2/bin/zstd
    cp contrib/pzstd/pzstd $PRE2/bin

    echo "[i] install ">&2

