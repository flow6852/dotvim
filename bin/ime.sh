#!/bin/bash -u

FloatingVim=$(swaymsg -t get_tree | jq -c '.. | .floating_nodes? | arrays[] | select(.app_id=="FloatingVim")')

if [ -z $FloatingVim ]; then
    NVIM_APPNAME=vime alacritty --option window.opacity=0.6 --class FloatingVim -e nvim /tmp/clipboard
    if [ -e /tmp/clipboard ]
    then
        cat /tmp/clipboard | xclip -selection clipboard
        rm /tmp/clipboard
    fi
else
    if [ "$(echo $FloatingVim | jq .focused)" = 'true' ]; then
        swaymsg "move window to scratchpad"
    else
        swaymsg "[app_id=\"FloatingVim\"] focus"
    fi
fi
