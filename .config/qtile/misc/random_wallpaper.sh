#!/bin/sh

feh --bg-scale --randomize ~/Pictures/Wallpapers/*
eval "set -- $(sed 1d "$HOME/.fehbg")" && betterlockscreen -u $4