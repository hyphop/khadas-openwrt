# Khadas OpenWrt VIMs

openwrt https://openwrt.org/ for Khadas VIMs boards https://www.khadas.com/vim

![Khadas VIM openwrt](pics/khadas_vim1_openwrt.jpg)

## supported Boards

+ khadas VIM1 - OK
+ khadas VIM2 - OK
+ khadas VIM3 - initial
+ khadas VIM3L - initial

NOTE:	this openwrt build works properly only with U-Boot 2015.01-g377aea7bb8 (Oct 15 2019 - 12:18:07)
	openwrt can boot with another uboots but not works properly!!!

## Download Images

+ https://dl.khadas.com/Firmware/VIM1/OpenWrt
+ https://dl.khadas.com/Firmware/VIM2/OpenWrt
+ https://dl.khadas.com/Firmware/VIM3/OpenWrt
+ https://dl.khadas.com/Firmware/VIM3L/OpenWrt
+ https://dl.khadas.com/Firmware/Krescue/images/

# OpenWrt Access

+ no root password
+ wifi ap mode enabled - no password
+ lan -> usb0 + wlan0 (usb net + wifi AP) in bridge mode
+ wan -> eth0 (dhcp)
+ serial console enabled -> ttyAML0
+ hdmi output -> tty0
+ web luci      http://openwrt-vim.local or http://172.23.0.1/
+ web-terminal  http://openwrt-vim.local:8088/ or http://172.23.0.1:8088/
+ ssh `root@openwrt-vim.local -p 22` or `root@172.23.0.1 -p 22`

# LAN ip resolve to local openwrt hosts

    172.23.0.1 openwrt-vim.local

# mDNS

+ OpenWrt._ssh._tcp.local
+ OpenWrt._http._tcp.local

# NOTES

+ blink led mode started if openwrt was successful loaded
+ setup root password and wifi password at fist after installation!
+ usb net connection enabled by default in bridge mode with LAN
+ if VIM device connected by usb cable to your pc u can have network access to LAN via usb-net without any extra configuration

## Install

just write image to SD card

### Linux - default installation method examples

    wget http://SERVER/IMAGE.sd.zip
    unzip -p IMAGE.sd.zip '*.img' | sudo dd bs=1M of=/dev/YOUR_SD_CARD

    wget http://SERVER/IMAGE.sd.img.gz
    gzip -dc IMAGE.sd.img.gz | sudo dd bs=1M of=/dev/YOUR_SD_CARD

    wget http://dl.khadas.com/Firmware/VIM1/OpenWrt/IMAGE.sd.img.gz -O- | gzip -dc | sudo dd bs=1M of=/dev/YOUR_SD_CARD

NOTE: Remember to replace the words **IMAGE** and **YOUR_SD_CARD**, to the correct values in your system.

### Another OS (or if previous methods were difficult for you) /  Linux - GUI

Use [Balena Etcher](https://www.balena.io/etcher/) to burn the OpenWrt image to your SD card or USB f.

    sudo ./balenaEtcher-1.5.57-x64.AppImage

Just select the IMAGE.img.gz or IMAGE.img.zip image, and select your SD card as the target. Press burn!
( There is no need to decompress the image )

## BOOT from SD card

+ Best way is to just boot openwrt from your SD card.
+ If your EMMC is empty, openwrt will automatically boot from your SD card.
+ Else, Uboot will start from EMMC by default - it can boot from SD card, but only with the proper version and config!

### VIM1 v12 (old) VIM2 v12 old

* Power on VIM1.
* Short-circuit the two pads of the M register (back PCB side), and without releasing it… https://docs.khadas.com/images/vim1/MRegister_ShortCircuit.png
* Short press the Reset key, then release it to force boot from SD card
https://docs.khadas.com/vim1/HowtoBootIntoUpgradeMode.html#MRegister-Mode-Maskrom-Mode

### VIM1 v14 (current) VIM2 v14 (current)

Just triple-press `KEY_F` (middle button) to force SD bootup!

## INSTALL to EMMC (internal storage)

* Write image to SD card.
* Open/mount SD card (OW_BOOT partition) on your PC.
* Activate this script `scripts/install2mmc_from_sd.script` which is stored in the first partition. Rename it from `install2mmc_from_sd.script.disabled` -> `install2mmc_from_sd.script`.
* Unmount/eject SD card from your PC .
* Insert SD card into VIM1 (TF card slot).
* Power on + force boot from SD card by triple pressing `KEY_F` (middle button).
* Wait for the "remove SD card" message to appear, before ejecting your SD card.
* OK! Well done! EMMC boot will occur automatically.

NOTE: All previous EMMC data will be lost!!!

### VIM3 VIM3L

#### Android default firmware

+ unplug usb cable
+ insert SD card with Krescue 
+ press and hold POWER_KEY 
+ plug usb cable and wait LED blinking after u can unpress POWER_KEY
+ ok Krescye system bootup from SD

NOTE: be sure usb cable powered from adapter not from PC

#### VIM3 VIM3L usb otg mode powered from PC

same as previous , but usb plug in host machine

need plug usb cable in two steps on host side

+ power without data pin connection - just slowly plug about 1/3 length usb header - before powerup
+ wait blinking leds and plug usb cable for full length for activate data pins

### eMMC is cleared

+ start from sd without special preparation

### multiboot instaled

+ start from sd without special preparation

### install to emmc inside openwrt booted from sd

    root@openwrt:/# mmc_install_from_sd

## how to Build from sources

+ https://github.com/hyphop/khadas-openwrt
+ https://openwrt.org/docs/guide-developer/source-code/start

## links

+ https://www.khadas.com/vim
+ https://dl.khadas.com/Firmware/VIM1/OpenWrt
+ https://dl.khadas.com/Firmware/VIM2/OpenWrt
+ https://dl.khadas.com/Firmware/VIM3/OpenWrt
+ https://dl.khadas.com/Firmware/VIM3L/OpenWrt
+ https://dl.khadas.com/Firmware/Krescue/images
+ https://docs.khadas.com
+ https://openwrt.org/

## Build by

    ## hyphop ##
