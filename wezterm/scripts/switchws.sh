#!/bin/sh

wezterm-switch-workspace() {
	args=$(jq -n --arg workspace "$1" --arg cwd "$2" '{"workspace":$workspace,"cwd":$cwd}' | base64)
	printf "\033]1337;SetUserVar=%s=%s\007" switch-workspace $args
}

project=$(fd --type d --max-depth 1 . "$HOME/Workspace/" | xargs realpath | sed "s|$HOME/Workspace/||" | fzf --preview 'eza --tree --color=always $HOME/Workspace/{} | head -200' --layout reverse --border)

if [[ -z $project ]]; then
    exit 0
fi
wezterm-switch-workspace $project $HOME/Workspace/$project
