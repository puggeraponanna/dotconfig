#!/usr/bin/env sh


tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    echo "tmux not running"
    exit 0
fi

current_branch=$(git branch --show-current)

selected=$(git branch -r | sed "s|.*origin/||" | fzf)

if [[ -z $selected ]]; then
    exit 0
fi

exists=$(git worktree list --porcelain | rg worktrees | rg $selected)

project_root=$(git worktree list --porcelain | rg worktrees | rg -v worktrees | sed "s|.*/User|/User|")

if [[ -z $exists ]]; then
    mkdir -p $project_root/worktrees
    git worktree add $project_root/worktrees/$selected $selected
fi

tmux new-window -n $selected -c $project_root/worktrees/$selected
