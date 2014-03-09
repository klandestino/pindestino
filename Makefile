all: testroot pindestino.img

testroot:
	@if [ "$$(whoami)" != "root" ]; then echo "Must be root. Run with sudo."; exit 1; fi

raspbian.zip:
	wget http://downloads.raspberrypi.org/raspbian_latest -O raspbian.zip

raspbian.img: raspbian.zip
	unzip raspbian.zip
	mv ????-??-??-wheezy-raspbian.img raspbian.img
	touch raspbian.img

pindestino.img: raspbian.img
	cp raspbian.img pindestino.img
	mkdir -p work
	mount -o loop,offset=4194304 pindestino.img work
	echo "pindestino aint nothin to fuk wit" >work/pindestino.txt
	sync
	umount -l work
	mount -o loop,offset=62914560 -t ext4 pindestino.img work
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
	
	# Our custom rc.local to start X:
	# cp rc.local work/etc/rc.local
	# chmod a+x work/etc/rc.local

	# add our install script to .bashrc.
	# since we are auto logging in on serial interface,
	# it will run at boot.
	cp work/home/pi/.bashrc work/home/pi/.bashrc-backup
	cat bashrc-install.sh >>work/home/pi/.bashrc
	# start virtual machine to run install script:
	sync
	umount -l work
	rmdir work
	qemu-system-arm -kernel kernel-qemu -cpu arm1176 -m 256 -M versatilepb -no-reboot -serial stdio -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" -hda pindestino.img
	mkdir -p work
	mount -o loop,offset=62914560 -t ext4 pindestino.img work
	# remove install script:
	cp work/home/pi/.bashrc-backup work/home/pi/.bashrc
	rm work/home/pi/.bashrc-backup

	sync
	umount -l work
	rmdir work
