#!/bin/bash
for F in $(ls features/iceweasel-plugins/xpis/*.xpi); do
	cp $F work/usr/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/
done
cd work/usr/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/
	for F in $(ls *.xpi); do
		mkdir tmp
		cd tmp
		unzip ../$F
		ID="$(cat install.rdf | grep em:id | head -1 | sed 's/^[^>]*>//' | sed 's/<.*$//')"
		cd ..
		mv tmp "$ID"
		rm $F
	done
cd ../../../../../..
