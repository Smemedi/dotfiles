number=$((1 + $RANDOM % 50))

guessNumber=$((1 + $RANDOM % 50))

if (( number == guessNumber )); then 
	echo I cant stop winning you got $number on both > ~/Scripts/grub_output.txt
	cp ~/grub/src/catppuccin-macchiato-grub-theme/logo.png ~/grub/src/catppuccin-macchiato-grub-theme/overlay.png
else
	echo you got $number but you should have gotten $guessNumber > ~/Scripts/grub_output.txt
	cp ~/grub/src/catppuccin-macchiato-grub-theme/transparent.png ~/grub/src/catppuccin-macchiato-grub-theme/overlay.png
fi
