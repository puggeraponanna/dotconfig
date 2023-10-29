#!/usr/bin/env sh


tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    echo "tmux not running"
    exit 0
fi

current_branch=$(git branch --show-current)

if [ $current_branch != "master" ]; then
    echo "do this from the master branch you idiot"
    exit 0
fi

selected=$(git branch -r | fzf)

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)


echo $selected
