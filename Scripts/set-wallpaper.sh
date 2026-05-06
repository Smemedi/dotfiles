#!/bin/bash

export XDG_RUNTIME_DIR="/run/user/$(id -u)"
#export WAYLAND_DISPLAY="wayland-0"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

hour=$(date +%-H)

if (( hour >= 1 && hour < 3 )); then
  num="1"

elif (( hour >= 3 && hour < 5 )); then
	num="3"
	
elif ((hour >= 5 && hour < 7 )); then
	num="5"

elif ((hour >= 7 && hour < 8 )); then
	num="7"

elif ((hour >= 8 && hour < 9 )); then
	num="8"

elif ((hour >= 9 && hour < 12 )); then
	num="9"

elif ((hour >= 12 && hour < 13 )); then
	num="12"

elif ((hour >= 13 && hour < 16 )); then
	num="13"

elif ((hour >= 16 && hour < 18 )); then
	num="16"

elif ((hour >= 18 && hour < 20 )); then
	num="18"

elif ((hour >= 20 && hour < 22 )); then
	num="20"

elif ((hour >= 22 || hour < 1 )); then
	num="22"

fi


awww img "$HOME/Pictures/wallpapers/$num.jpg" --transition-type any --transition-fps 60 --transition-duration 3
