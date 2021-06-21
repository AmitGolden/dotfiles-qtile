#!/bin/bash

# default monitor is eDP1
MONITOR=eDP1
pacmd set-card-profile 0 output:analog-stereo+input:analog-stereo

# functions to switch from eDP1 to HDMI and vice versa
function ActivateHDMI {
    xrandr --output HDMI1 --auto --scale-from 1920x1080 --output eDP1
    pacmd set-card-profile 0 output:hdmi-stereo
    MONITOR=HDMI1
}
function DeactivateHDMI {
    pacmd set-card-profile 0 output:analog-stereo+input:analog-stereo
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

    sleep 5s
done