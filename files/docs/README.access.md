# OpenWrt Access

+ no root password
+ wifi ap mode enabled - no password
+ lan -> usb0 + wlan0 (usb net + wifi AP) in bridge mode
+ wan -> eth0 (dhcp)
+ serial console enabled -> ttyAML0
+ hdmi output -> tty0
+ web interface http://openwrt-vim.local
+ web interface http://172.23.0.1.local
+ ssh root@openwrt-vim.local -p 22
+ ssh root@172.23.0.1 -p 22

# LAN ip resolve to local openwrt hosts

    172.23.0.1 openwrt-vim.local

# mDNS

+ openwrt-vim.local
+ OpenWrt._ssh._tcp.local
+ OpenWrt._http._tcp.local

# NOTES

+ blink led mode started if openwrt was successful loaded
+ setup root password and wifi password at fist after installation!
+ usb net connection enabled by default in bridge mode with LAN
+ if vim device connected by usb cable to your pc u can have network access to LAN via usb-net without any extra configuration

