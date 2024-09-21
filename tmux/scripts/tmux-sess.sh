#!/usr/bin/env sh


selected=$(fd --type d --max-depth 1 . "$HOME/Workspace/" | xargs realpath | sed "s|$HOME/Workspace/||" | fzf --preview 'eza --tree --color=always $HOME/Workspace/{} | head -200' --layout reverse --border)


if [[ -z $selected ]]; then
    exit 0
fi

tmux_running=$(pgrep tmux)

selected_path="$HOME/Workspace/$selected"

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected -c $selected_path
    exit 0
fi


if ! tmux has-session -t=$selected 2> /dev/null; then
    tmux new-session -ds $selected -c $selected_path
fi

tmux switch-client -t $selected
