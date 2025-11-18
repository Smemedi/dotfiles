#!/bin/bash

pkill -f swaync-client -t -sw

# Trigger a fresh scan
bluetoothctl scan on >/dev/null 2>&1 &
sleep 3
bluetoothctl scan off >/dev/null 2>&1

# List devices: MAC + Name
devices=$(bluetoothctl devices | awk '{print $2, $3, $4, $5, $6}')

# If no devices found
[ -z "$devices" ] && exit

selected=$(echo "$devices" \
  | wofi --dmenu --hide-search --conf ~/.config/wofi/config-wifi)

# User canceled
[ -z "$selected" ] && exit

mac=$(echo "$selected" | awk '{print $1}')

# Try to connect
bluetoothctl connect "$mac"

