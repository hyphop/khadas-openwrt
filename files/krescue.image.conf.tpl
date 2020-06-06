#!/bin/sh

echo "[i] template run args
DATE=\"$DATE\" LABEL=$LABEL
sh krescue.image.conf.tpl">&2

cat <<end # krescue image script config template

# krescue image script config

#    __ _____                      
#   / //_/ _ \___ ___ ______ _____ 
#  / ,< / , _/ -_|_-</ __/ // / -_)
# /_/|_/_/|_|\__/___/\__/\_,_/\__/ 
#                                  
# krescue advanced install system  

## header block
image:		$KRESQ_IMAGE_NAME
type:		emmc
format:		kresq
#args:		-comp gzip
args:		-comp zstd -Xcompression-level 22 -b 1M
builder:	hyphop
date:		$DATE
link:		http://dl.khadas.com/Firmware
label:		OPENWRT
match:		BOARD=VIM1
match:		BOARD=VIM2
match:		BOARD=VIM3
match:		BOARD=VIM3L
match:		BOARD=Edge
vars:		BOARD=VIM1 VIM2 VIM3 VIM3L Edge
source:		README*
source:		.meta
duration:	6
desc:		$KRESQ_IMAGE_DESC
    OpenWrt is an open source project for embedded operating systems based on Linux,
    primarily used on embedded devices to route network traffic. 
    The main components are Linux, util-linux, musl, and BusyBox.

## sub archive already packed sfs
sub:	2
data:	OW_DATA/openwrt_khadas.squashfs

# sub 1
sub:	1
source:	OW_BOOT*

## raw data block
block:  0
start:  0
sub:	1
data:   OW_BOOT/boot/%%BOARD%%.u-boot.sd.bin

## partition + fs block
part:	1
type:	-
start:	4194304
size:	100M
fstype:	vfat
label:	
source:	OW_BOOT

## partition + fs block
part:	2
type:	-
start:	4194304
size:	900M
data:	#2
data:	+@zero:64M
uuid:	-

##END##
end
