# INSTALL to EMMC (internal storage) Khadas Openwrt Vims 

1) Write image to SD card.
2) Open/mount SD card (first partition) on your PC.
3) Activate this script `install2mmc_from_sd.script` which is stored in the first SD partition.
Rename it from `install2mmc_from_sd.script.disabled` -> `install2mmc_from_sd.script`.
4) Unmount/eject SD card from your PC .
5) Insert SD card into VIM1 (SD card slot).
6) Power on + force boot from SD card by triple pressing `KEY_F` (middle button), or read `README.sd.boot.md`
7) Wait for the "DONE !! plz remove sd card and reboot from eMMC" message to appear, before ejecting your SD card.
8) OK! Well done! EMMC boot will occur automatically.

NOTE: All previous EMMC data will be lost!!!

## inside openwrt

    root@openwrt:/# mmc_install_from_sd

or install after - next boot

    remount_rw /boot
    cd boot/scripts/
    mv install2mmc_from_sd.script.disabled install2mmc_from_sd.script
    reboot
