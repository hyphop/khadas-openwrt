# OpenWrt VIMs Change log

## Khadas Vims OpenWrt rel 0.3.1

+ ethernet for VIM2 fixed, hotplug & reinit without bugs! OK

## Khadas Vims OpenWrt rel 0.3

+ added support for VIM2 ( with wifi chip AP6356S VIM2.V14 test mode )
+ preinstalled samba, mdns, ttyd, thd + many other packages
+ fix ethernet for VIM2, but still not possible reinit ethernet interface for VIM2
+ improve startup speed - now is about 7 sec
+ LEDs indicators - supported
+ board buttons KEY_F KEY_P - custom usage KEY_F - reset wifi | KEY_P - power off
+ initial optimization for Ethernet USB MMC subsystems
+ many improves
+ change default hostname to openwrt-vim + mdns name to: openwrt-vim.local

## Khadas Vims OpenWrt rel 0.2

+ usb 3g 4g modems - OK
+ improve build scripts
+ some changes

## Khadas Vims OpenWrt rel 0.1

it's a firt release for Khadas Vims boards

+ vim1 ver 1.2 - OK
+ vim1 ver 1.4 - OK
+ mainline linux kernel 5.3.0-*
+ OPENWRT release 18.06.4
+ khadas fan - OK
+ usb otg net -> bridge lan
+ eth0 -> wan
+ wifi driver [ brcmfmac ]
+ wifi chips SDIO_ID=02D0:A9A6 brcm/brcmfmac43430-sdio for chip BCM43430/1  (AP6212) - OK
+ wifi chips SDIO_ID=02D0:A9BF brcm/brcmfmac43455-sdio for chip BCM4345/6, (AP6255 ) - OK
+ wifi chips SDIO_ID=02D0:4356 brcm/brcmfmac4356-sdio for chip BCM4356/2, (AP6356S) - TESTMODE
+ boot from SD - OK
+ SD -> eMMC installation - OK
+ boot from eMMC - OK
+ HDMI - OK
+ UART - OK
+ i2c  - OK
+ led  - OK
+ VPNs ready

