#!/bin/sh
upower -i $(upower -e | grep 'BAT') | grep -E "state|percentage"