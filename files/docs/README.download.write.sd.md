# Download Khadas vims Openwrt images

## Download and write

+ https://github.com/hyphop/khadas-openwrt/releases
+ https://dl.khadas.com/Firmware/VIM1/OpenWrt
+ https://dl.khadas.com/Firmware/VIM2/OpenWrt
+ https://dl.khadas.com/Firmware/VIM3/OpenWrt
+ https://dl.khadas.com/Firmware/VIM3L/OpenWrt

```
cd /tmp
wget https://github.com/hyphop/khadas-openwrt/releases/download/0.1/VIM1.OPENWRT.sd.img.gz
gzip -dc VIM1.OPENWRT.sd.img.gz | sudo dd bs=1M of=/dev/SD_PATH
sync
```

from mirrors

```
wget https://dl.khadas.com/Firmware/VIM1/OpenWrt/VIM1.OPENWRT.sd.img.gz
```

