#!/bin/sh
while true; do

	# Clean up previously running apps, gracefully at first then harshly
	killall -TERM iceweasel 2>/dev/null;
	killall -TERM matchbox-window-manager 2>/dev/null;
	sleep 2;
	killall -9 iceweasel 2>/dev/null;
	killall -9 matchbox-window-manager 2>/dev/null;

	# Clean out existing profile information
	rm -rf /home/pi/.cache;
	rm -rf /home/pi/.config;
	rm -rf /home/pi/.pki;

	# Disable DPMS / Screen blanking
	xset -dpms
	xset s off

	# Reset the framebuffer's colour-depth
	fbset -depth $( cat /sys/module/*fb*/parameters/fbdepth );

	# Hide the cursor (move it to the bottom-right, comment out if you want mouse interaction)
	xwit -root -warp $( cat /sys/module/*fb*/parameters/fbwidth ) $( cat /sys/module/*fb*/parameters/fbheight )

	# Start the window manager (remove "-use_cursor no" if you actually want mouse interaction)
	matchbox-window-manager -use_titlebar no &

	# Set keyboard layout from configuration.
	KEYBOARDLAYOUT="$(cat /tmp/app/pindestino.conf | ruby -ryaml -e "data = YAML::load(STDIN.read); puts data['kbmap']")"
	if [ "$KEYBOARDLAYOUT" != "" ]; then
		setxkbmap "$KEYBOARDLAYOUT"
	fi
	
	# Start the browser (See http://peter.sh/experiments/chromium-command-line-switches/)
	iceweasel http://127.0.0.1/

done;
