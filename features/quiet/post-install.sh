#!/bin/bash

cp splash0.png work/etc/splash0.png
cp splash1.png work/etc/splash1.png
cp splash2.png work/etc/splash2.png
cp splash3.png work/etc/splash3.png

echo 'logo.nologo vt.global_cursor_default=0 dwc_otg.lpm_enable=0 console=tty2 quiet root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline rootwait' >workboot/cmdline.txt

# remove ttys to save some ram.
sed -i 's/1:.* tty1//' work/etc/inittab
sed -i 's/3:.* tty3//' work/etc/inittab
sed -i 's/4:.* tty4//' work/etc/inittab
sed -i 's/5:.* tty5//' work/etc/inittab
sed -i 's/6:.* tty6//' work/etc/inittab

