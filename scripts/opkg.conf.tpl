#!/bin/sh

# hyphop #

#= opkg.conf template

[ "$REL" ] || {
    PR=$(dirname $0)
    echo "[i] autoconf from $PR/build.conf">&2
    . $PR/build.conf
}

#
# opkg config template
#

cat <<end

src/gz openwrt_core http://downloads.openwrt.org/releases/$REL/targets/$TARGET/$BITS/packages
src/gz openwrt_base http://downloads.openwrt.org/releases/$REL/packages/$OWARCH/base
src/gz openwrt_luci http://downloads.openwrt.org/releases/$REL/packages/$OWARCH/luci
src/gz openwrt_packages http://downloads.openwrt.org/releases/$REL/packages/$OWARCH/packages
src/gz openwrt_routing http://downloads.openwrt.org/releases/$REL/packages/$OWARCH/routing
src/gz openwrt_telephony http://downloads.openwrt.org/releases/$REL/packages/$OWARCH/telephony

arch all 100
arch $OWARCH 200

dest root $OWTMP
dest ram /tmp

lists_dir ext $OPKG_LIST

#option overlay_root ../tmp/overlay
#option check_signature

end
