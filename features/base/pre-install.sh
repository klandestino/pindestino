#!/bin/bash

# tag it
echo "pindestino aint nothin to fuk wit" >workboot/pindestino.txt

# some stuff to make raspbian work nicer in qemu:
cp work/etc/ld.so.preload work/etc/ld.so.preload.backup
echo "" >work/etc/ld.so.preload
echo 'KERNEL=="sda", SYMLINK+="mmcblk0"' >work/etc/udev/rules.d/90-qemu.rules
echo 'KERNEL=="sda?", SYMLINK+="mmcblk0p%n"' >>work/etc/udev/rules.d/90-qemu.rules
echo 'KERNEL=="sda2", SYMLINK+="root"' >>work/etc/udev/rules.d/90-qemu.rules

# disable raspi-config.sh at (first) boot:
rm work/etc/profile.d/raspi-config.sh

# auto login on serial interface:
sed -i work/etc/inittab \
	-e "s/^#\(.*\)#\s*RPICFG_TO_ENABLE\s*/\1/" \
	-e "/#\s*RPICFG_TO_DISABLE/d" \
	-e "/ttyAMA0/d"
echo "T0:23:respawn:/bin/login -f pi ttyAMA0 </dev/ttyAMA0 >/dev/ttyAMA0 2>&1" >>work/etc/inittab

