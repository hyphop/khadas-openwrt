## BOOT from SD card

+ Best way is to just boot openwrt from your SD card.
+ If your EMMC is empty, openwrt will automatically boot from your SD card. (goto uboot console and run `store init 3` for erase emmc)
+ Else, Uboot will start from EMMC by default - it can boot from SD card, but only with the proper version and config!

### VIM1 v14 (current) VIM2 v14

Just triple-press `KEY_F` (middle button) to force SD bootup!

### VIM1 v12 (old) VIM2 v12 (old)

* Power on VIM device
* Short-circuit the two pads of the M register (back PCB side), and without releasing it… https://docs.khadas.com/images/vim1/MRegister_ShortCircuit.png
* Short press the Reset key, then release it to force boot from SD card
https://docs.khadas.com/vim1/HowtoBootIntoUpgradeMode.html#MRegister-Mode-Maskrom-Mode

## INSTALL to EMMC (internal storage)

* Write image to SD card.
* Open/mount SD card (OW_BOOT partition) on your PC.
* Activate this script `scripts/install2mmc_from_sd.script` which is stored in the first partition. Rename it from `install2mmc_from_sd.script.disabled` -> `install2mmc_from_sd.script`.
* Unmount/eject SD card from your PC .
* Insert SD card into VIM1 (TF card slot).
* Power on + force boot from SD card by triple pressing `KEY_F` (middle button).
* Wait for the "remove SD card" message to appear, before ejecting your SD card.
* OK! Well done! EMMC boot will occur automatically.

NOTE: All previous EMMC data will be lost!!!
