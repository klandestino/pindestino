#!/bin/bash

cp splash0.png work/etc/splash0.png
cp splash1.png work/etc/splash1.png
cp splash2.png work/etc/splash2.png
cp splash3.png work/etc/splash3.png

echo 'logo.nologo vt.global_cursor_default=0 dwc_otg.lpm_enable=0 console=tty2 quiet root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline rootwait' >workboot/cmdline.txt

sed -i 's/1:.* tty1//' work/etc/inittab

