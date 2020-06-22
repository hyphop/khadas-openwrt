#!script

## hyphop ##

#= uboot script boot openwrt ext4 image

## PREPARE

kbi hwver
echo "** KRESCUE START hwver: $hwver hostname: $hostname maxcpus: $maxcpus **"

  BOOT_DELAY=1

  LINUX_ADDR=0x1080000
  IMAGE_ADDR=0x1080000

UINITRD_ADDR=0x8000000
 UIMAGE_ADDR=0x6000000
 INITRD_ADDR=0x3000000

    DTB_ADDR=0x1000000
dtb_mem_addr=0x1000000

   LOGO_ADDR2=0x31000000
   LOGO_ADDR=0x30000000
    ENV_ADDR=0x32000000
 SCRIPT_ADDR=0x33000000

    LABEL=OPENWRT

    ROOTFS=
    FSLOAD=load
    setenv Cenv     /boot/user.env
    setenv Cdtb     /boot/linux.dtb
    setenv Csplash  /boot/splash.bmp.gz

test "$distro_bootcmd" = "" || setenv Csplash /splash.bmp

    setenv CuInitrd /boot/uInitrd
    setenv CImage  /boot/Image
    setenv CuImage  /boot/uImage.gzip


test "$devnum" = "" && $FSLOAD mmc 0 $loadaddr $LABEL.label && setenv devnum 0
test "$devnum" = "" && $FSLOAD mmc 1 $loadaddr $LABEL.label && setenv devnum 1
test "$devnum" = "" && $FSLOAD mmc 2 $loadaddr $LABEL.label && setenv devnum 2
test "$devnum" = "" && $FSLOAD usb 0 $loadaddr $LABEL.label && setenv devnum 0 && setenv devtype usb

test "$devnum"  = "" && setenv devnum 0
test "$devtype" = "" && setenv devtype mmc


    setenv LOADER "$FSLOAD $devtype $devnum"

    echo "[i] openwrt loaded $LOADER"

DTB_EDGE=/boot/fdt/rockchip/rk3399-khadas-edge-v.dtb
DTB_VIM3=/boot/fdt/amlogic/meson-g12b-a311d-khadas-vim3.dtb
DTB_VIM31=/boot/fdt/amlogic/meson-g12b-s922x-khadas-vim3.dtb
DTB_VIM2=/boot/fdt/amlogic/meson-gxm-khadas-vim2.dtb
DTB_VIM1=/boot/fdt/amlogic/meson-gxl-s905x-khadas-vim.dtb
DTB_VIM3L=/boot/fdt/amlogic/meson-sm1-khadas-vim3l.dtb

    setenv Cdtb     /boot/openwrt.dtb


if test "$hwver" = ""; then
    echo "[w] hwver not defined"
else 
    test "$hwver" = "VIM1.V12" && setenv Cdtb $DTB_VIM1
    test "$hwver" = "VIM1.V13" && setenv Cdtb $DTB_VIM1
    test "$hwver" = "VIM1.V14" && setenv Cdtb $DTB_VIM1
    test "$hwver" = "VIM2.V12" && setenv Cdtb $DTB_VIM2
    test "$hwver" = "VIM2.V14" && setenv Cdtb $DTB_VIM2
    test "$hwver" = "VIM3.V10" && setenv Cdtb $DTB_VIM3
    test "$hwver" = "VIM3.V11" && setenv Cdtb $DTB_VIM3
fi

if test "$maxcpus" = ""; then
    echo "[w] maxcpus not defined"
    test "$hostname" = "arm_gxbb" && setenv Cdtb $DTB_VIM3L
    test "$hostname" = "KVIM3" && setenv Cdtb $DTB_VIM3
    test "$hostname" = "kVIM1" && setenv Cdtb $DTB_VIM1
else
    test "$hwver" = "VIM3.V12" && test "$maxcpus" = "4" && setenv Cdtb $DTB_VIM3L
    test "$maxcpus" = "6" && setenv Cdtb $DTB_VIM3
    test "$maxcpus" = "8" && setenv 
fi

## emmc MAINLINE UBOOT 
test "$fdtfile" = "amlogic/meson-sm1-khadas-vim3l.dtb"       && setenv Cdtb $DTB_VIM3L
test "$fdtfile" = "amlogic/meson-gxl-s905x-khadas-vim.dtb"   && setenv Cdtb $DTB_VIM1
test "$fdtfile" = "amlogic/meson-gxm-khadas-vim2.dtb"        && setenv Cdtb $DTB_VIM2
test "$fdtfile" = "amlogic/meson-g12b-a311d-khadas-vim3.dtb" && setenv Cdtb $DTB_VIM3
test "$fdtfile" = "amlogic/meson-g12b-s922x-khadas-vim3.dtb" && setenv Cdtb $DTB_VIM31

#boot_source=sd

VENDOR_=""

test "$fdtfile" = "rockchip/rk3399-khadas-edge-v.dtb"       && setenv Cdtb $DTB_EDGE && VENDOR_=rockchip
test "$fdtfile" = "rockchip/rk3399-khadas-edge-captain.dtb" && setenv Cdtb $DTB_EDGE && VENDOR_=rockchip
test "$fdtfile" = "rockchip/rk3399-khadas-edge.dtb"         && setenv Cdtb $DTB_EDGE && VENDOR_=rockchip

if test "$Cdtb" = "/boot/openwrt.dtb"; then
    echo "[w] dtb not detected force use static: $Cdtb"
fi

test "$boot_source" = "" || setenv BOOTED $boot_source

test "$ROOTFS" = "" -a "$devtype" = "usb" && ROOTFS=root=/dev/sda2
test "$ROOTFS" = "" -a "$devnum"  = "0"   && ROOTFS=root=/dev/mmcblk0p2
test "$ROOTFS" = "" -a "$devnum"  = "1"   && ROOTFS=root=/dev/mmcblk1p2
test "$ROOTFS" = "" -a "$devnum"  = "2"   && ROOTFS=root=/dev/mmcblk2p2
test "$ROOTFS" = "" -a "$devnum"  = "0:1" && ROOTFS=root=/dev/mmcblk0p2
test "$ROOTFS" = "" -a "$devnum"  = "1:1" && ROOTFS=root=/dev/mmcblk1p2
test "$ROOTFS" = "" -a "$devnum"  = "2:1" && ROOTFS=root=/dev/mmcblk2p2


echo "[i] openwrt rootfs $ROOTFS // DTB: $Cdtb"

test "$VENDOR_" != "" -a "$ROOTFS" = "root=/dev/mmcblk0p2" && ROOTFS=root=/dev/mmcblk2p2

test "$Cdtb" = "$DTB_VIM1" -a "$ROOTFS" = "root=/dev/mmcblk2p2" && ROOTFS=root=/dev/mmcblk1p2
test "$Cdtb" = "$DTB_VIM2" -a "$ROOTFS" = "root=/dev/mmcblk2p2" && ROOTFS=root=/dev/mmcblk1p2

echo "[i] openwrt rootfs $ROOTFS ((fixed))"

##############################################################

echo "load env"
echo "$LOADER $ENV_ADDR $Cenv"

$LOADER $ENV_ADDR $Cenv || exit
echo env import -t $ENV_ADDR $filesize
env import -t $ENV_ADDR $filesize || exit

##############################################################

test "$fdt_addr_r"     = "" || setenv DTB_ADDR     $fdt_addr_r
test "$ramdisk_addr_r" = "" || setenv UINITRD_ADDR $ramdisk_addr_r
test "$kernel_addr_r"  = "" || setenv UIMAGE_ADDR  $kernel_addr_r

echo "addrs:  UIMAGE_ADDR ::  UINITRD_ADDR ::  DTB_ADDR"
echo "addrs: $UIMAGE_ADDR :: $UINITRD_ADDR :: $DTB_ADDR"
echo "setenv kernel_addr_r $kernel_addr_r; setenv ramdisk_addr_r $ramdisk_addr_r; setenv fdt_addr_r $fdt_addr_r;"

echo ":::::::::::::::"

echo "load dtb"
echo $LOADER $DTB_ADDR $Cdtb
$LOADER $DTB_ADDR $Cdtb
fdt addr $DTB_ADDR || exit 1
#

#SPI_=spifc
#test "$VENDOR_" = "" || SPI_=spi1
#fdt set $SPI_ status okay

#osd open
#osd clear

#echo "load logo $Csplash or $Csplash.gz"
#test "$Csplash" = "" || $LOADER $LOGO_ADDR $Csplash && setenv $Csplash ""
#test "$Csplash" = "" || $LOADER $LOGO_ADDR2 $Csplash.gz && unzip $LOGO_ADDR2 $LOGO_ADDR && setenv $Csplash ""
#test "$Csplash" = "" || bmp display $LOGO_ADDR m m

#echo "load packed initrd"
#echo $LOADER $UNITRD_ADDR $CuInitrd
#$LOADER $UINITRD_ADDR $CuInitrd

echo "load packed kernel"
echo $LOADER $UIMAGE_ADDR $CuImage
$LOADER $UIMAGE_ADDR $CuImage

# mainline
#BOOTED
#boot_source

#setenv bootargs "${cmdline} booted=$BOOTED hwver=$hwver root=$ROOTFS rootwait rw"

# dont use uboot config

setenv bootargs ""

CONSOLE_="console=ttyAML0,115200n8 console=ttyS0,115200n8"

test "$VENDOR_" = "" || CONSOLE_="console=uart8250,mmio32,0xff1a0000"

setenv bootargs "${bootargs} console=tty0 $CONSOLE_ no_console_suspend consoleblank=0 module_blacklist=f2fs"

#setenv bootargs "${bootargs} vout=${outputmode},enable hdmitx=${cecconfig},${colorattribute}"
#setenv bootargs "${bootargs} hdmimode=${hdmimode} cvbsmode=${cvbsmode} osd_reverse=${osd_reverse}"
#setenv bootargs "${bootargs} video_reverse=${video_reverse} jtag=${jtag} ddr_size=${ddr_size}"

setenv bootargs "${bootargs} dtb=$Cdtb"
setenv bootargs "${bootargs} $ROOTFS"
setenv bootargs "${bootargs} booted=$BOOTED hwver=$hwver ${cmdline}"
setenv bootargs "${bootargs} vt.default_utf8=1"

# autodetect fix green
osd12=
test "$fdtfile" = "" || osd12=osd12
setenv bootargs "${bootargs} $osd12"

#echo "activate emmc before run"
#mmc dev 1
#mmc info

echo "[i] bootargs: $bootargs"
echo "[i] bootcmd:  $bootcmd"

echo "[i] sleep $BOOT_DELAY sec Ctrl+C for break boot"
sleep $BOOT_DELAY

setenv UINITRD_ADDR -

echo "try:: $LOADER $UIMAGE_ADDR $CImage"
$LOADER $UIMAGE_ADDR $CImage && echo "booti $UIMAGE_ADDR $UINITRD_ADDR $DTB_ADDR" && booti $UIMAGE_ADDR $UINITRD_ADDR $DTB_ADDR

echo $LOADER $UIMAGE_ADDR $CuImage
$LOADER $UIMAGE_ADDR $CuImage
echo bootm $UIMAGE_ADDR $UINITRD_ADDR $DTB_ADDR
bootm $UIMAGE_ADDR $UINITRD_ADDR $DTB_ADDR

echo oooopsss fail not $LABEL

sleep 5

##END##

