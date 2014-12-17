#!/bin/bash

echo 'vt.global_cursor_default=0 dwc_otg.lpm_enable=0 console=tty2 quiet root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline rootwait' >workboot/cmdline.txt

