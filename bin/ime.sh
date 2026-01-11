#!/bin/bash -u

FloatingVim=$(swaymsg -t get_tree | jq -c '.. | .floating_nodes? | arrays[] | select(.app_id=="FloatingVim")')

if [ -z "${FloatingVim}" ]; then
    NVIM_APPNAME=vime alacritty --option window.opacity=0.6 --option window.dimensions.columns=60 window.dimensions.lines=10 --class FloatingVim -e "${HOME}/.local/nvim/bin/nvim" /tmp/clipboard
    if [ -e /tmp/clipboard ]
    then 
        pgrep startx
        status=$?
        if [ $status -ne 1 ]
         then
            xclip -selection clipboard -i /tmp/clipboard
        else
            wl-copy < /tmp/clipboard
        fi
        rm /tmp/clipboard
    fi
else
    if [ "$(echo "${FloatingVim}" | jq .focused)" = 'true' ]; then
        swaymsg "move window to scratchpad"
    else
        swaymsg "[app_id=\"FloatingVim\"] focus"
    fi
fi
