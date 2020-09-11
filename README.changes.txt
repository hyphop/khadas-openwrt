# OpenWrt VIMs Change log

## Khadas Vims OpenWrt rel 0.73

+ linux kernel 5.7.7
+ updated openwrt base 
+ fixed boot scripts
+ fixed eth mac for VIM3x
+ fixed sd boot problem with legacy uboot 
+ updated uboot

## Khadas Vims OpenWrt rel 0.7

+ add Khadas Edge (rockchip rk3399) - https://docs.khadas.com/edge/
+ linux kernel 5.7
+ one kernel for amlogic and rockchip
+ wireguard
+ pcie + nvme
+ some other fixes

## Khadas Vims OpenWrt rel 0.66

+ linux kernel fix usb-starage uas bug (just disable uas)
+ linux kernel other fixes ... 
+ uboot changed to last mainline khadas version
+ green screen bug fixed for any uboot version
+ uboot script autodetect rootfs
+ boot from usb storages

## Khadas Vims OpenWrt rel 0.63

+ change default dns resolver all via https-dns
+ change firewall users scripts /etc/firewall.user
+ small configs changes
+ f2fs blacklisted - overlay troubles with f2fs usage

## Khadas Vims OpenWrt rel 0.62

+ change default rel to OpenWrt 19.07.2
+ change default uboot to mainline
+ improve build tc

## Khadas Vims OpenWrt rel 0.61

+ change default rel to OpenWrt 19.07.1
+ update image build scripts
+ improve uboot scripts and config
+ add mainline uboot support + root env store to emmc fat partition

## Khadas Vims OpenWrt rel 0.6

+ Final release of OpenWrt 19.07.0
+ improve openwrt 19.07.X series
+ add WIFI modules support for VIM3 VIM3L boards ( sdio id 02D0:4359 AP6398S)
+ initial overlay build support
+ add f2fs overlay support

## Khadas Vims OpenWrt rel 0.5

+ add VIM3 and VIM3L initial support (without on board wifi)
+ add new kernel for VIM3L
+ prepare build scripts for openwrt 19.07.X series
+ add RTL8153 Gigabit Ethernet Adapter ( USB3.0 - 0bda:8153 - r8152 )
+ USB3.0 expand ready
+ network config add - USB eth1 bridged with usb0 as LAN
+ https://github.com/hyphop/khadas-openwrt/releases/tag/19.07.0-rc2
+ https://www.reddit.com/r/openwrt/comments/e6uzmq/openwrt_19070rc2_for_khadas_vim3_vim3l_boards/

## Khadas Vims OpenWrt rel 0.4

+ add SQM support https://openwrt.org/docs/guide-user/network/traffic-shaping/sqm
+ rebuild linux kernel and modules config
+ improve build scripts | `scripts/build +server` - build server variant
+ prepare build scripts for openwrt 19.07.X series `cat scripts/build_last_rel.md` https://openwrt.org/releases/19.07/notes-19.07.0-rc1
+ add NFS-kernel-server only for 19.07.X server series - `nfsd_test` script test

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

