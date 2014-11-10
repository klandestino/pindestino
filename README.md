pindestino
==========

Pindestino is a linux distribution/image for Raspberry Pi, built on top of Raspbian.

At boot, Pindestino will:

1. Start any Node.js application that is on your USB device.
2. Start Iceweasel in fullscreen, kiosk mode style.
3. Direct Iceweasel to http://127.0.0.1/ (that is your Node.js app).
 
More features:
* Pindestino mounts your SD card and your USB as read-only, so the Raspberry can be unplugged without a proper shutdown.
* If you put a Iceweasel/Firefox extension (.xpi file) on your USB device, it will be installed before Iceweasel starts.


Build image
-----------

make must run as root, since the build will loopback mount the image:

	# sudo make


Booting image in qemu
---------------------

	# qemu-system-arm -kernel kernel-qemu -cpu arm1176 -m 256 -M versatilepb -no-reboot -serial stdio -append "root=/dev/sda2 rootfstype=ext4 ro" -drive file=pindestino.img,index=1,readonly,media=disk


Write image to SD card
----------------------

	# sudo dd bs=4M if=pindestino.img of=/dev/mmcblk0
	# sudo sync
