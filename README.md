pindestino
==========

Pindestino is a linux distribution/image for Raspberry Pi, built on top of Raspbian.


Booting image in qemu
---------------------

	# qemu-system-arm -kernel kernel-qemu -cpu arm1176 -m 256 -M versatilepb -no-reboot -serial stdio -append "root=/dev/sda2 rootfstype=ext4 ro" -drive file=pindestino.img,index=1,readonly,media=disk


Write image to SD cart
----------------------

	# sudo dd bs=4M if=pindestino.img of=/dev/mmcblk0
	# sudo sync
