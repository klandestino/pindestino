#!/bin/bash

sudo apt-get install -y fbi

sudo chmod a+x /etc/init.d/asplashscreen
sudo insserv /etc/init.d/asplashscreen

