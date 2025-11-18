#!/bin/bash

# Close panel (or toggle it)
pkill -f swaync-client -t -sw
# small pause

# Run the menu in a separate session so swaync never crashes
nmcli --fields "SSID,SECURITY,SIGNAL" device wifi list | sed '1d' \
  | wofi --dmenu --hide-search --conf ~/.config/wofi/config-wifi \
  | awk '{print $1}' \
  | xargs -r -I{} nmcli device wifi connect "{}"

