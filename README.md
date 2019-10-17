# khadas openwrt [![Build Status](https://travis-ci.com/hyphop/khadas-openwrt.svg?branch=master)](https://travis-ci.com/hyphop/khadas-openwrt)

openwrt for Khadas VIMs boards https://www.khadas.com/vim

![vim1_openwrt.jpg](pics/vim1_openwrt.jpg)

## Build

```
git clone https://github.com/hyphop/khadas-openwrt.git
cd khadas-openwrt
# ./scripts/build_prepare
./scripts/build
```


## Images

+ https://github.com/hyphop/khadas-openwrt/releases/
+ https://dl.khadas.com/Firmware/VIM1/OpenWrt
+ https://dl.khadas.com/Firmware/VIM2/OpenWrt
+ https://dl.khadas.com/Firmware/VIM3/OpenWrt
+ https://dl.khadas.com/Firmware/VIM3L/OpenWrt

## Installation

just write iamge to SD card

```
cd /tmp
wget https://github.com/hyphop/khadas-openwrt/releases/download/0.1/vim1.OPENWRT.sd.img.gz
gzip -dc vim1.OPENWRT.sd.img.gz | sudo dd bs=1M of=/dev/SD_PATH
sync

out mirror

```
wget https://dl.khadas.com/Firmware/VIM1/OpenWrt/vim1.OPENWRT.sd.img.gz
```

## docs & how to

read more docs ...
[files/docs](files/docs)
[README.openwrt.vims.md](README.openwrt.vims.md)

## related projects

+ https://github.com/hyphop/khadas-linux-kernel
+ https://github.com/hyphop/khadas-uboot-spi
+ https://github.com/hyphop/khadas-rescue

## links

+ https://openwrt.org/
+ https://www.khadas.com/vim
+ https://github.com/khadas
+ https://docs.khadas.com
