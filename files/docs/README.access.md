# openwrt Access info

+ no root password
+ wifi ap mode enabled - no password
+ lan -> usb0 + wlan0 (usb net + wifi AP) in bridge mode
+ wan -> eth0 (dhcp)
+ serial console enabled -> ttyAML0
+ hdmi output -> tty0
+ web interface http://172.23.0.1
+ ssh root@172.23.0.1 -p 22

NOTE: blink led mode started if openwrt was successful loaded

NOTE: setup root password and wifi password at fist after installation!

NOTE: usb net connection enabled by default, 

NOTE: if vim device powered by usb cable from pc u can have network access to LAN via usb-net without any extra configuration

