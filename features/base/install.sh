# this script runs as user pi, but we do have sudo access.

# update packages
sudo apt-get update

# for the graphical environment:
sudo apt-get install -y matchbox iceweasel x11-xserver-utils xwit

# locales...
sudo apt-get install -y locales-all

# remove disk swap:
sudo swapoff --all
sudo dphys-swapfile swapoff
sudo dphys-swapfile uninstall
sudo update-rc.d -f dphys-swapfile remove
sudo apt-get purge -y dphys-swapfile
sudo rm /var/swap

# can not clean fs at boot, since we are read only:
sudo update-rc.d -f checkroot-bootclean.sh remove
# clean now instead:
sudo rm -Rf /tmp/* /tmp/.*

# auto mount usb drives:
sudo apt-get install -y usbmount

# adding nodejs
curl http://nodejs.org/dist/v0.10.21/node-v0.10.21-linux-arm-pi.tar.gz | tar xvzf -
sudo mkdir /opt/nodejs
sudo mv node-v0.10.21-linux-arm-pi/* /opt/nodejs
rm -Rf node-v0.10.21-linux-arm-pi

# dont start daemons at boot.
sudo /etc/init.d/ssh stop
sudo update-rc.d ssh disable

sudo /etc/init.d/triggerhappy stop
sudo update-rc.d triggerhappy disable

sudo /etc/init.d/nfs-common stop
sudo update-rc.d nfs-common disable

sudo /etc/init.d/rpcbind stop
sudo update-rc.d rpcbind disable

sudo /etc/init.d/rsync stop
sudo update-rc.d rsync disable

# disable ipv6 to save resources
echo "net.ipv6.conf.all.disable_ipv6=1" > /etc/sysctl.d/disableipv6.conf
echo 'blacklist ipv6' >> /etc/modprobe.d/blacklist
sed -i '/::/s%^%#%g' /etc/hosts



