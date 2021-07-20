#!/bin/bash

# default monitor is eDP1
MONITOR=eDP1
pacmd set-card-profile 0 output:analog-stereo+input:analog-stereo

MODE=mirror

function turn_off {
    xrandr --output HDMI1 --off
}

function extend {
    turn_off
    xrandr --output HDMI1 --auto --mode 1920x1080 --right-of eDP1
    dunstify -r 42000 'Extend Display'
}

function mirror {
    turn_off
    xrandr --output HDMI1 --auto --scale-from 1920x1080 --output eDP1
    dunstify -r 42000 'Mirror Display'
}

function toggle_mode {
    if [[ $MODE == 'mirror' ]]; then
        extend
        MODE='extend'
    else
        mirror
        MODE='mirror'
    fi
    echo "$MODE"
}


trap toggle_mode 10

# functions to switch from eDP1 to HDMI and vice versa
function ActivateHDMI {
    if [[ $MODE == 'extend' ]]; then
        extend
    else
        mirror
    fi
    pacmd set-card-profile 0 output:hdmi-stereo+input:analog-stereo
    MONITOR=HDMI1
}
function DeactivateHDMI {
    pacmd set-card-profile 0 output:analog-stereo+input:analog-stereo
    turn_off
    MONITOR=eDP1
}

# functions to check if HDMI is connected and in use
function HDMIActive {
    [ $MONITOR = "HDMI1" ]
}
function HDMIConnected {
    ! xrandr | grep "^HDMI1" | grep disconnected
}

# actual script
while true
do
    if ! HDMIActive && HDMIConnected
    then
        ActivateHDMI
    fi

    if HDMIActive && ! HDMIConnected
    then
        DeactivateHDMI
    fi

    sleep 5s &
    wait $!
done