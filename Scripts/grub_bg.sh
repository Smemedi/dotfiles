#!/bin/bash

number=$((1 + $RANDOM % 50))

guessNumber=$((1 + $RANDOM % 50))

if (( number == guessNumber )); then 
	cp /usr/share/grub/themes/Grub/face.png /usr/share/grub/themes/Grub/overlay.png
else
	cp /usr/share/grub/themes/Grub/transparent.png /usr/share/grub/themes/Grub/overlay.png
fi
