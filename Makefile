all: pindestino.img

raspbian.zip:
	wget http://downloads.raspberrypi.org/raspbian_latest -O raspbian.zip

raspbian.img: raspbian.zip
	unzip raspbian.zip
	mv ????-??-??-wheezy-raspbian.img raspbian.img
	touch raspbian.img

pindestino.img: raspbian.img
	cp raspbian.img pindestino.img
