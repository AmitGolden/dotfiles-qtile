#!/bin/bash

isActive=0
isManual=0

function enable_caffeine {
    if [[ $isActive == 0 ]]; then
        dunstify -r 6969 "Caffeine Enabled"
        xset s off -dpms
        echo 1 > ~/.config/qtile/caffeine/isActive
    fi
    isManual=$1
    isActive=1
}

function disable_caffeine {
    if [[ $isActive == 1 ]]; then
        dunstify -r 6969 "Caffeine Disabled"
        xset s on dpms
        echo 0 > ~/.config/qtile/caffeine/isActive
    fi
    isActive=0
    isManual=0
}

function toggle_caffeine {
    if [[ $isActive == 1 ]]; then
        disable_caffeine
    else
        enable_caffeine 1
    fi
}

trap toggle_caffeine 10
trap disable_caffeine EXIT

displays=""
while read id
do
    displays="$displays $id"
done< <(xvinfo | sed -n 's/^screen #\([0-9]\+\)$/\1/p')

function join_by {
    local IFS="$1";
    shift;
    echo "$*";
}

importantPrograms=(zoom)

importantProgramsRunning() {
    regex=$(join_by '|' "${importantPrograms[@]}")
    procNum=$(ps aux | grep -E "$regex" | sed '$d' | wc -l)

    if [[ $procNum > 0 ]]; then
        true
    else
        false
    fi
}

checkFullscreen()
{
    bool=0

    # loop through every display looking for a fullscreen window
    for display in $displays
    do
        #get id of active window and clean output
        activ_win_id=`DISPLAY=:0.${display} xprop -root _NET_ACTIVE_WINDOW`
        activ_win_id=${activ_win_id:40:9}

        # Check if Active Window (the foremost window) is in fullscreen state
        isActivWinFullscreen=`DISPLAY=:0.${display} xprop -id $activ_win_id | grep _NET_WM_STATE_FULLSCREEN`
        if [[ "$isActivWinFullscreen" == *NET_WM_STATE_FULLSCREEN* ]]; then
			bool=1
	    fi
    done

    if [[ $bool == 1 ]]; then
        true
    else
        false
    fi
}

while true; do
    if (checkFullscreen || importantProgramsRunning); then
        enable_caffeine 0
    elif [[ $isManual == 0 ]]; then
        disable_caffeine
    fi

    sleep 15 &
    wait $!
done

exit 0
