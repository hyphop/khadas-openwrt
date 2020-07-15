#!/bin/sh

## hyphop ##

#= make simg2img

# need bison

D=$(dirname $0)

. $D/make_

VER=2.35
NAME=util-linux
PKG=$NAME-$VER.tar.gz

echo "[i] make $PKG">&2

../download https://github.com/karelzak/$NAME/archive/v$VER.tar.gz "" $PKG || exit 1

cd $DL

D=${PKG%.tar.*}

[ -d $D ] || \
    tar -xf $PKG

cd *$D

./autogen.sh
./configure --prefix="$PRE2"

make $MAKE_MT && \
    make install-usrlib_execLTLIBRARIES 2>/dev/null && \
    cp .libs/sfdisk $PRE2/bin
