#!/bin/sh
if pgrep -x wofi > /dev/null; then
	echo ffff
else
	wofi --show drun
	echo ooooo
fi
