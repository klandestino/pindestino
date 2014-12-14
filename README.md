pindestino
==========

Pindestino is a linux distribution/image for Raspberry Pi, built on top of Raspbian.

At boot, Pindestino will:

1. Start any Node.js application that is on your USB device.
2. Start Iceweasel in fullscreen, kiosk mode style.
3. Direct Iceweasel to http://127.0.0.1/ (that is your Node.js app).
 
More features:
* Pindestino mounts your SD card and your USB as read-only, so the Raspberry can be unplugged without a proper shutdown.


Build image
-----------

make must run as root, since the build will loopback mount the image:

	# sudo make


Booting image in qemu
---------------------

	# qemu-system-arm -kernel kernel-qemu -cpu arm1176 -m 256 -M versatilepb -no-reboot -serial stdio -append "root=/dev/sda2 rootfstype=ext4 ro" -drive file=pindestino.img,index=1,readonly,media=disk


Write image to SD card
----------------------

Something like: (Make sure /dev/mmcblk0 is the correct device!)

	# sudo dd bs=4M if=pindestino.img of=/dev/mmcblk0
	# sudo sync


Prepare your USB drive
----------------------

At boot, Pindestino will search for a USB device with the files app/package.json and app/pindestino.conf. Both those files must exist. It will then change directory (cd) into the app directory, and execute npm start.

Any node js application depenencies must be in the app/node_modules directory. NOTE: Binary modules must be of the Raspberry Pi architecture.

Your node.js application must listen at port 80. Otherwise, X11 and Iceweasel will not start.


app/pindestino.conf
-------------------

The app/pindestino.conf should be on your USB stick, and it will set some configuration for your pindestino. It should be in YAML format. Example:

	wifi:
		network: MYWIFI
		password: secret
	usb: rw
	bootscript: ./autostart.sh

To set Wifi network name and password:

	wifi:
		network: MYWIFI
		passwork: secret

To mount your USB in read-write mode:

	usb: rw

To run a bootscript (before "npm start"). Note that it is relative to the USB's app directory. 

	bootscript: ./autostart.sh


