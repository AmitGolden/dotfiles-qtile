#!/bin/env sh

TERMINAL=$(ps -o comm= -p "$(($(ps -o ppid= -p "$(($(ps -o sid= -p "$$")))")))")

if [[ $TERMINAL == 'kitty' ]]; then
	kitty @ set-spacing padding=0
	nvim $*
	kitty @ set-spacing padding=default
else
	nvim $*
fi