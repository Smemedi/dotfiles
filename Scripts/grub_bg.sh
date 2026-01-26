number=$((1 + $RANDOM % 50))

guessNumber=$((1 + $RANDOM % 50))

if (( number == guessNumber )); then 
	cp ~/grub/src/catppuccin-macchiato-grub-theme/logo.png ~/grub/src/catppuccin-macchiato-grub-theme/overlay.png
else
	cp ~/grub/src/catppuccin-macchiato-grub-theme/transparent.png ~/grub/src/catppuccin-macchiato-grub-theme/overlay.png
fi
