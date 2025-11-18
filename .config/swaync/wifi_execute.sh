#!/bin/sh
if pgrep -f connex > /dev/null; then
	echo ffff
else
	connex
	echo ooooo
fi
