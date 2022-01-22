#!/bin/sh

killall redshift
killall nm-applet
killall caffeine.sh
killall display_handler.sh
killall blueman-applet
killall polkit-gnome-authentication-agent-1
killall dunst
killall sleep.sh
killall picom

imwheel

# gnome-keyring-daemon -d &
~/.config/qtile/misc/display_handler.sh &
setxkbmap -layout "us,il" -option "grp:alt_shift_toggle" &
~/.config/qtile/misc/random_wallpaper.sh &
picom --config ~/.config/qtile/picom.conf &
~/.config/qtile/caffeine/caffeine.sh &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
~/.config/qtile/caffeine/sleep.sh &
nm-applet &
blueman-applet &
redshift-gtk &
dunst &
