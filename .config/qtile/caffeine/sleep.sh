#!/bin/bash

xidlehook \
	--not-when-fullscreen \
	--not-when-audio \
	--detect-sleep \
	--timer 270 \
		'temp=$(xbacklight -get | cut -d. -f1); xbacklight -set $((temp / 2))' \
		'xbacklight -set 100' \
	--timer 30 \
		'~/.config/qtile/misc/lock.sh; xbacklight -set 0' \
		'xbacklight -set 100' \
	--timer 3600 \
		'systemctl suspend' \
		''