#!/bin/bash

# Our custom rc.local to extract home dir and start X:
cp rc.local work/etc/rc.local
chmod a+x work/etc/rc.local

# script for starting chromium when X starts:
cp xinitrc work/home/pi/.xinitrc
chmod a+x work/home/pi/.xinitrc

# use 4.2.2.1 for dns. remove old dhcp leases. make dhcp leases writeable.
echo "nameserver 4.2.2.1" >work/etc/resolv.conf
cp dhclient.conf work/etc/dhcp/dhclient.conf
rm -Rf work/var/lib/dhcp
ln -s /tmp work/var/lib/dhcp

# make pi home dir tar file and symlink home dir to tmp:
cd work/home
tar cjvaf pi.tar.bz2 pi
rm -Rf pi
ln -s /tmp pi
cd ../..

# usbmount config to mount readonly
cp usbmount.conf work/etc/usbmount/usbmount.conf

# fstab:
cp fstab work/etc/fstab

# rw config:
mkdir -p work/etc/rw

# network config in rw:
rm work/etc/network/interfaces
ln -s /etc/rw/interfaces work/etc/network/interfaces
cp default-networking work/etc/default/networking

# timezone in rw:
rm work/etc/localtime
rm work/etc/timezone
ln -s /etc/rw/localtime work/etc/localtime
ln -s /etc/rw/timezone work/etc/timezone

# config.txt
cp config.txt workboot/config.txt

