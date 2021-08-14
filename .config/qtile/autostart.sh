#!/bin/sh

killall redshift
killall nm-applet
killall caffeine.sh
# killall blueman-applet
# killall polkit-gnome-authentication-agent-1
# killall dunst

echo 2 > /tmp/libinput_discrete_deltay_multiplier &

# gnome-keyring-daemon -d &
~/.config/qtile/misc/display_handler.sh &
setxkbmap -layout "us,il" -option "grp:alt_shift_toggle" &
feh --bg-scale --randomize ~/Pictures/Wallpapers/* && eval "set -- $(sed 1d "$HOME/.fehbg")" && betterlockscreen -u $4 &
picom --config ~/.config/qtile/picom.conf &
~/.config/qtile/caffeine/caffeine.sh &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
~/.config/qtile/caffeine/sleep.sh &
nm-applet &
blueman-applet &
redshift-gtk &
dunst &