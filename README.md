# khadas openwrt

openwrt for Khadas VIMs boards

## status 

just begin state!

## build from sources

    to be posted soon, now only for test, need some time for test and preparing normal usable version!

## screenshots

[openwrt.png][pics/openwrt.png]

## how to ...

now i can provide only next info...

extlinux format config

    LABEL Openwrt-VIM
    #LINUX /uImage.lzma
    LINUX /Image
    FDT /dtb/kvim3_linux.dtb
    APPEND root=/dev/ram0 rw init=/init panic=10 net.ifnames=0 loglevel=3 console=tty0 console=ttyS0,115200n8 ...

full linux boot command line

    # cat /proc/cmdline 
    root=/dev/ram0 rw init=/init panic=10 net.ifnames=0 loglevel=3 console=tty0 console=ttyS0,115200n8 no_console_suspend consoleblank=0 vout=1080p60hz,enable hdmitx=,444,8bit hdmimode=1080p60hz cvbsmode=576cvbs osd_reverse=0 video_reverse=0 jtag=disable reboot_mode= ddr_size=4 hwver=VIM3.V11 wol_enable=0 wifi_ssid=VIM3 

kernel

    https://github.com/hyphop/khadas-linux-kernel/releases/download/test/Image.lzma
    https://github.com/hyphop/khadas-linux-kernel/releases/download/test/uImage.lzma

dtb

    https://github.com/hyphop/khadas-linux-kernel/releases/download/test/kvim3_linux.dtb


initrd / ramdisk

+ https://github.com/hyphop/khadas-openwrt/releases/download/test/initramfs-rescue.xz.squashfs
+ https://github.com/hyphop/khadas-openwrt/releases/download/test/uinitramfs-rescue.xz.squashfs


## related projects

+ https://github.com/hyphop/khadas-linux-kernel
+ https://github.com/hyphop/khadas-uboot-spi
+ https://github.com/hyphop/khadas-rescue

## links

+ https://github.com/khadas
+ https://docs.khadas.com
