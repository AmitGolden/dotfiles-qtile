#!/bin/env sh

if [[ $TERM == 'xterm-kitty' ]]; then
	kitty @ set-spacing padding=0
	nvim $*
	kitty @ set-spacing padding=default
else
	nvim $*
fi