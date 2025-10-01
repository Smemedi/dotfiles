#!/bin/bash

export XDG_RUNTIME_DIR="/run/user/$(id -u)"
#export WAYLAND_DISPLAY="wayland-0"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

hour=$(date +%-H)

# Path to your wallpapers, change this to your actual image folder
wallpaper_dir="$HOME/wallpapers"

if (( hour >= 22 || (hour >= 0 && hour <= 4) )); then
  swww img "$HOME/wallpapers/first.jpg" --transition-type any --transition-fps 60 --transition-duration 3

elif (( hour >= 5 && hour <= 7 )); then
  swww img "$HOME/wallpapers/second.jpg" --transition-type any --transition-fps 60 --transition-duration 3

elif ((hour >= 8 && hour <= 9 )); then
  swww img "$HOME/wallpapers/third.jpg" --transition-type any --transition-fps 60 --transition-duration 3

elif ((hour >= 10 && hour <= 11 )); then
  swww img "$HOME/wallpapers/fourth.jpg" --transition-type any --transition-fps 60 --transition-duration 3

elif ((hour >= 12 && hour <= 14 )); then
  swww img "$HOME/wallpapers/fifth.jpg" --transition-type any --transition-fps 60 --transition-duration 3

elif ((hour >= 15 && hour <= 16 )); then
  swww img "$HOME/wallpapers/sixth.jpg" --transition-type any --transition-fps 60 --transition-duration 3

elif ((hour >= 17 && hour <= 19 )); then
  swww img "$HOME/wallpapers/seventh.jpg" --transition-type any --transition-fps 60 --transition-duration 3

elif ((hour >= 20 && hour <= 21 )); then
  swww img "$HOME/wallpapers/eighth.jpg" --transition-type any --transition-fps 60 --transition-duration 3
fi
