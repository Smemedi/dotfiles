#!/bin/sh
if pgrep -f hyprshot > /dev/null; then
    exit 0
else
    hyprshot -m window -o ~/Pictures/Screenshots
fi
