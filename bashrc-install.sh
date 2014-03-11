# this script runs as user pi, but we do have sudo access.

# for the graphical environment:
sudo apt-get install -y matchbox chromium x11-xserver-utils ttf-mscorefonts-installer xwit sqlite3 libnss3

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

sudo sync
sudo reboot
