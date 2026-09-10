#!/bin/sh

if ! pgrep -x wofi > /dev/null; then
    wofi --show drun
fi
