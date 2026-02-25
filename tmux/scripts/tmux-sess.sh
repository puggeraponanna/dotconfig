#!/usr/bin/env sh


selected=$(fd --type d --max-depth 1 . "$HOME/Workspace/" | xargs realpath | sed "s|$HOME/Workspace/||" | fzf --preview 'eza --tree --color=always $HOME/Workspace/{} | head -200')

if [[ -z $selected ]]; then
    exit 0
fi

tmux_running=$(pgrep tmux)

selected_path="$HOME/Workspace/$selected"
session_name=$(echo "$selected" | tr '.' '_')

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s "$session_name" -c "$selected_path" -n main
    exit 0
fi


if ! tmux has-session -t="$session_name" 2> /dev/null; then
    tmux new-session -ds "$session_name" -c "$selected_path" -n main
fi

tmux switch-client -t "$session_name"
