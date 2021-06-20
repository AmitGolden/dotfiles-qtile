#!/bin/sh

killall redshift
killall nm-applet
killall caffeine
# killall blueman-applet
# killall polkit-gnome-authentication-agent-1
# killall dunst

# gnome-keyring-daemon -d &
~/.config/qtile/display_handler.sh &
setxkbmap -layout "us,il" -option "grp:alt_shift_toggle" &
feh --bg-scale --randomize ~/Pictures/Wallpapers/* && eval "set -- $(sed 1d "$HOME/.fehbg")" && betterlockscreen -u $4 -b &
picom --config ~/.config/qtile/picom.conf &
caffeine start &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xss-lock -- ~/.config/qtile/lock &
nm-applet &
blueman-applet &
redshift-gtk &
dunst &