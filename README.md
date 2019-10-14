# khadas openwrt [![Build Status](https://travis-ci.com/hyphop/khadas-openwrt.svg?branch=master)](https://travis-ci.com/hyphop/khadas-openwrt)

openwrt for Khadas VIMs boards


## screenshots

## Build

```
git clone https://github.com/hyphop/khadas-openwrt.git
cd khadas-openwrt
# ./scripts/build_prepare
./scripts/build

```

![openwrt.png](pics/openwrt.png)

## Images

+ https://github.com/hyphop/khadas-openwrt/releases/

## Installation

just write iamge to SD card

```
cd /tmp
wget https://github.com/hyphop/khadas-openwrt/releases/download/0.1/OPENWRT.vim1.vfat.img.gz
gzip -dc OPENWRT.vim1.vfat.img.gz | sudo dd bs=1M of=/dev/SD_PATH
sync
```

## docs

[files/docs](files/docs)

## how to ...

## related projects

+ https://github.com/hyphop/khadas-linux-kernel
+ https://github.com/hyphop/khadas-uboot-spi
+ https://github.com/hyphop/khadas-rescue

## links

+ https://github.com/khadas
+ https://docs.khadas.com
