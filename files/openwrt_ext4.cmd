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

   LOGO_ADDR=0x30000000
    ENV_ADDR=0x32000000
 SCRIPT_ADDR=0x33000000

    LABEL=OPENWRT

    ROOTFS=/dev/mmcblk0p1
    FSLOAD=load
    setenv Cenv     /boot/user.env
    setenv Cdtb     /boot/linux.dtb
    setenv Csplash  /boot/splash.bmp.gz
    setenv CuInitrd /boot/uInitrd
    setenv CuImage  /boot/uImage.gzip

test "$devnum" = "" && $FSLOAD mmc 0:1 $loadaddr $LABEL.label && setenv devnum 0:1
test "$devnum" = "" && $FSLOAD mmc 1:1 $loadaddr $LABEL.label && setenv devnum 1:1
test "$devnum" = "" && $FSLOAD mmc 2:1 $loadaddr $LABEL.label && setenv devnum 2:1
test "$devnum" = "" && setenv devnum 0

    test "X$devtype" = "X" && devtype=mmc

    setenv LOADER "$FSLOAD $devtype $devnum"

    echo "[i] openwrt loaded $LOADER"

    setenv Cdtb     /boot/krescue-vim.dtb

if test "$hwver" = ""; then
    echo "[w] hwver not defined"
else 
    test "$hwver" = "VIM1.V12" && setenv Cdtb /boot/krescue-vim1.dtb
    test "$hwver" = "VIM1.V13" && setenv Cdtb /boot/krescue-vim1.dtb
    test "$hwver" = "VIM1.V14" && setenv Cdtb /boot/krescue-vim1.dtb
    test "$hwver" = "VIM2.V12" && setenv Cdtb /boot/krescue-vim2.dtb
    test "$hwver" = "VIM2.V14" && setenv Cdtb /boot/krescue-vim2.dtb
    test "$hwver" = "VIM3.V10" && setenv Cdtb /boot/krescue-vim3-s922x.dtb
    test "$hwver" = "VIM3.V11" && setenv Cdtb /boot/krescue-vim3-a311d.dtb
fi

if test "$maxcpus" = ""; then
    echo "[w] maxcpus not defined"
    test "$hostname" = "arm_gxbb" && setenv Cdtb /boot/krescue-vim3-s905d3.dtb
    test "$hostname" = "KVIM3" && setenv Cdtb /boot/krescue-vim3-a311d.dtb
    test "$hostname" = "kVIM1" && setenv Cdtb /boot/krescue-vim1.dtb
else
    test "$hwver" = "VIM3.V12" && test "$maxcpus" = "4" && setenv Cdtb /boot/krescue-vim3-s905d3.dtb
    test "$maxcpus" = "6" && setenv Cdtb /boot/krescue-vim3-a311d.dtb
    test "$maxcpus" = "8" && setenv Cdtb /boot/krescue-vim2.dtb
fi

## emmc MAINLINE UBOOT 
test "$fdtfile" = "amlogic/meson-sm1-khadas-vim3l.dtb" && setenv Cdtb /boot/krescue-vim3-s905d3.dtb
test "$fdtfile" = "amlogic/meson-gxl-s905x-khadas-vim.dtb" && setenv Cdtb /boot/krescue-vim1.dtb
test "$fdtfile" = "amlogic/meson-gxm-khadas-vim2.dtb" && setenv Cdtb /boot/krescue-vim2.dtb
test "$fdtfile" = "amlogic/meson-g12b-a311d-khadas-vim3.dtb" && setenv Cdtb /boot/krescue-vim3-a311d.dtb

#boot_source=sd

if test "$Cdtb" = "/boot/krescue-vim.dtb"; then
    echo "[w] dtb not detected force use static: $Cdtb"
fi


##############################################################

echo "load env"
echo "$LOADER $ENV_ADDR $Cenv"

$LOADER $ENV_ADDR $Cenv || exit
echo env import -t $ENV_ADDR $filesize
env import -t $ENV_ADDR $filesize || exit

##############################################################

echo "load dtb"
echo $LOADER $DTB_ADDR $Cdtb
$LOADER $DTB_ADDR $Cdtb
fdt addr $DTB_ADDR || exit 1
#
# fdt set spifc status okay

#osd open
#osd clear

echo "load logo"
echo $LOADER $LOGO_ADDR $Csplash
$LOADER $LOGO_ADDR $Csplash
bmp display $LOGO_ADDR 0 0

#echo "load packed initrd"
#echo $LOADER $UNITRD_ADDR $CuInitrd
#$LOADER $UINITRD_ADDR $CuInitrd

echo "load packed kernel"
echo $LOADER $UIMAGE_ADDR $CuImage
$LOADER $UIMAGE_ADDR $CuImage

#setenv bootargs "${cmdline} booted=$BOOTED hwver=$hwver root=$ROOTFS rootwait rw"

# dont use uboot config

setenv bootargs ""

setenv bootargs "${bootargs} console=tty0 console=ttyAML0,115200n8 console=ttyS0,115200n8 no_console_suspend consoleblank=0"

#setenv bootargs "${bootargs} vout=${outputmode},enable hdmitx=${cecconfig},${colorattribute}"
#setenv bootargs "${bootargs} hdmimode=${hdmimode} cvbsmode=${cvbsmode} osd_reverse=${osd_reverse}"
#setenv bootargs "${bootargs} video_reverse=${video_reverse} jtag=${jtag} ddr_size=${ddr_size}"

setenv bootargs "${bootargs} dtb=$Cdtb"
setenv bootargs "${bootargs} booted=$BOOTED hwver=$hwver ${cmdline}"
setenv bootargs "${bootargs} vt.default_utf8=1"

#echo "activate emmc before run"
#mmc dev 1
#mmc info

echo "[i] bootargs: $bootargs"
echo "[i] bootcmd:  $bootcmd"

echo "[i] sleep $BOOT_DELAY sec Ctrl+C for break boot"
sleep $BOOT_DELAY

echo bootm $UIMAGE_ADDR - $DTB_ADDR
bootm $UIMAGE_ADDR - $DTB_ADDR

#echo bootm $UIMAGE_ADDR $UINITRD_ADDR $DTB_ADDR
#bootm $UIMAGE_ADDR $UINITRD_ADDR $DTB_ADDR

echo oooopsss fail not $LABEL

sleep 5

##END##

