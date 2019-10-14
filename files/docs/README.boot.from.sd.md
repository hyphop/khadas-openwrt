# Openwrt Vims boot

## BOOT from SD card

+ Best way is to just boot system from your SD card.
+ If your EMMC is empty, system will automatically boot from your SD card.
+ Else, Uboot will start from EMMC by default - it can boot from SD card, but only with the proper version and config!

### VIM1_v12 (old)

1) Power on VIM1.
2) Short-circuit the two pads of the M register (back PCB side), and without releasing it… https://docs.khadas.com/images/vim1/MRegister_ShortCircuit.png
3) Short press the Reset key, then release it to force boot from SD card
https://docs.khadas.com/vim1/HowtoBootIntoUpgradeMode.html#MRegister-Mode-Maskrom-Mode

### VIM1 v14 (current)

Just triple-press `KEY_F` (middle button) to force SD bootup!
