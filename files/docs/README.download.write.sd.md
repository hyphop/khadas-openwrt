# Khadas vims Openwrt

## Download and write

+ https://github.com/hyphop/khadas-openwrt/releases

```
cd /tmp
wget https://github.com/hyphop/khadas-openwrt/releases/download/0.1/OPENWRT.vim1.vfat.img.gz
gzip -dc OPENWRT.vim1.vfat.img.gz | sudo dd bs=1M of=/dev/SD_PATH
sync
```

