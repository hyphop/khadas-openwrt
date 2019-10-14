# openwrt fs

## image types

+ vfat => vfat | squashfs + ext4(overlay)

```
root@OpenWrt:/# blkid
/dev/loop0: LABEL="rootfs_data" UUID="fa818cd0-87a6-46dc-ac01-7a13c0c46169" TYPE="ext4"
/dev/mmcblk1: PTUUID="90e70f1e" PTTYPE="dos"
/dev/mmcblk1p1: SEC_TYPE="msdos" LABEL="OW_BOOT" UUID="DEAD-BEEF" TYPE="vfat" PARTUUID="90e70f1e-01"
/dev/mmcblk1p2: TYPE="squashfs" PARTUUID="90e70f1e-02"

root@OpenWrt:/# losetup
NAME       SIZELIMIT   OFFSET AUTOCLEAR RO BACK-FILE  DIO LOG-SEC
/dev/loop0         0 25427968         0  0 /mmcblk1p2   0     512

root@OpenWrt:/# cat /proc/mounts 
/dev/root /rom squashfs ro,relatime 0 0
devtmpfs /rom/dev devtmpfs rw,relatime,size=469452k,nr_inodes=117363,mode=755 0 0
tmpfs /tmp tmpfs rw,nosuid,nodev,noatime 0 0
/dev/loop0 /overlay ext4 rw,noatime 0 0
overlayfs:/overlay / overlay rw,noatime,lowerdir=/,upperdir=/overlay/upper,workdir=/overlay/work 0 0

```
