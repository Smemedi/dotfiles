#!/bin/sh
if pgrep -f hyprshot > /dev/null; then
    exit 0
else
    hyprshot -m region -o ~/Pictures/Screenshots
fi
