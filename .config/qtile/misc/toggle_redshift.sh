#!/usr/bin/env bash

REDSHIFT_PID=$(pidof -s redshift)

if [[ $? == 0 ]] ; then
    kill -s USR1 $REDSHIFT_PID
    notify-send --app-name="toggle_redshift.sh" "Toggled Redshift"
else
    echo "Could not find PID of redshift!" 1>&2
    notify-send --app-name="redshift-toggle_redshift.sh" --urgency=critical "Could not find PID of redshift!"
fi