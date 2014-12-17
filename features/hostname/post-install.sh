#!/bin/bash

echo 'pindestino' >work/etc/hostname
sed -i 's/raspberrypi/pindestino/' work/etc/hosts

rm work/etc/os-release.orig
cat <<_EOF_ >work/etc/os-release
PRETTY_NAME="Pindestino GNU/Linux 1"
NAME="Pindestino GNU/Linux"
VERSION_ID="1"
VERSION="1"
ID=pindestino
ID_LIKE=debian
ANSI_COLOR="1;31"
HOME_URL="http://klandestino.github.io/pindestino/"
SUPPORT_URL="https://github.com/klandestino/pindestino"
BUG_REPORT_URL="https://github.com/klandestino/pindestino/issues"
_EOF_

echo 'Pindestino GNU/Linux 1\n \l' >work/etc/issue
echo '' >>work/etc/issue
echo 'Pindestino GNU/Linux 1' >work/etc/issue.net
rm work/etc/issue.orig
rm work/etc/issue.net.orig

