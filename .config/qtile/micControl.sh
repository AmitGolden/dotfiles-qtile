#!/usr/bin/env bash

# You can call this script like this:
# $ ./volumeControl.sh up
# $ ./volumeControl.sh down
# $ ./volumeControl.sh mute

# Script modified from these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

function get_volume {
  amixer get Capture | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
  amixer get Capture | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
  iconSound="audio-input-microphone-high"
  iconMuted="audio-input-microphone-muted"
  if is_mute ; then
    dunstify -i $iconMuted -r 2594 -u normal "Mic muted"
  else
    volume=$(get_volume)
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq --separator="─" 0 "$(((volume - 1) / 4))" | sed 's/[0-9]//g')
    space=$(seq --separator=" " 0 "$(((100 - volume) / 4))" | sed 's/[0-9]//g')
    # Send the notification
    dunstify -i $iconSound -r 2594 -u normal "|$bar$space| $volume%"
  fi
}

case $1 in
  up)
    # set the volume on (if it was muted)
    # amixer set Master on > /dev/null
    # up the volume (+ 5%)
    amixer set Capture 5%+ > /dev/null
    send_notification
    ;;
  down)
    # amixer -D pulse set Master on > /dev/null
    amixer set Capture 5%- > /dev/null
    send_notification
    ;;
  mute)
    # toggle mute
    amixer set Capture 1+ toggle > /dev/null
    send_notification
    ;;
esac