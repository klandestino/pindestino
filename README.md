pindestino
==========

Pindestino is a linux distribution/image for Raspberry Pi, built on top of Raspbian.


Booting image in qemu
---------------------

	# qemu-system-arm -kernel kernel-qemu -cpu arm1176 -m 256 -M versatilepb -no-reboot -serial stdio -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" -hda pindestino.img
