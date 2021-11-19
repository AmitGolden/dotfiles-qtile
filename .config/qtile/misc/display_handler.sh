#!/bin/bash

# default monitor is eDP1
MONITOR=eDP1
pacmd set-card-profile 0 output:analog-stereo+input:analog-stereo

MODE=mirror

# functions to check if HDMI is connected and in use
function HDMIActive {
    [ $MONITOR = "HDMI1" ]
}
function HDMIConnected {
    ! xrandr | grep "^HDMI1" | grep disconnected
}


function turn_off {
    xrandr --output HDMI1 --off
}

function extend {
    turn_off
    # xrandr --output HDMI1 --mode 1920x1200 --right-of eDP1
    xrandr --output HDMI1 --preferred --right-of eDP1
    pacmd set-card-profile 0 output:analog-stereo+input:analog-stereo
    dunstify -r 42000 'Extend Display'
    ~/.config/qtile/misc/random_wallpaper.sh &
}

function mirror {
    turn_off
    xrandr --output HDMI1 --auto --scale-from 1920x1080 --output eDP1
    pacmd set-card-profile 0 output:hdmi-stereo+input:analog-stereo
    dunstify -r 42000 'Mirror Display'
    ~/.config/qtile/misc/random_wallpaper.sh &
}

function toggle_mode {
    if HDMIActive; then
        if [[ $MODE == 'mirror' ]]; then
            extend
            MODE='extend'
        else
            mirror
            MODE='mirror'
        fi
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
    MONITOR=HDMI1
}
function DeactivateHDMI {
    pacmd set-card-profile 0 output:analog-stereo+input:analog-stereo
    turn_off
    MONITOR=eDP1
}


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