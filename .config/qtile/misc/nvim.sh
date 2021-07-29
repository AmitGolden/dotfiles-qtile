#!/bin/env sh

TERM=$(ps -o comm= -p "$(($(ps -o ppid= -p "$(($(ps -o sid= -p "$$")))")))")

if [[ $TERM == 'kitty' ]]; then
	kitty @ set-spacing padding=0
	nvim $*
	kitty @ set-spacing padding=default
else
	nvim $*
fi