#!/bin/bash

isActive=$(cat ~/.config/qtile/caffeine/isActive)

if [[ $isActive == 1 ]]; then
	echo 
else
	echo ﯈
fi