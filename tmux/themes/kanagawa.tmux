#!/usr/bin/env bash

set -g mode-style "fg=#7E9CD8,bg=#1F1F28"

set -g message-style "fg=#7E9CD8,bg=#1F1F28"
set -g message-command-style "fg=#7E9CD8,bg=#1F1F28"

set -g pane-border-style "fg=#1F1F28"
set -g pane-active-border-style "fg=#7E9CD8"

set -g status "on"
set -g status-justify "left"

set -g status-style "fg=#7E9CD8,bg=#1F1F28"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#1F1F28,bg=#7E9CD8,bold] #S "
set -g status-right "#[fg=#C8C093,bg=#1F1F28] %Y-%m-%d | %I:%M %p #[fg=#1d202f,bg=#7E9CD8,bold] #h "

setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#C8C093,bg=#1F1F28"
setw -g window-status-format "#[fg=#1F1F28,bg=#1F1F28,nobold,nounderscore,noitalics]#[default] #I | #W "
setw -g window-status-current-format "#[fg=#1F1F28,bg=#C8C093,nobold,nounderscore,noitalics] #I | #W "

