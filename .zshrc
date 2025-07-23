eval "$(/opt/homebrew/bin/brew shellenv)"
 
export EDITOR=nvim
export VISUAL=nvim

alias vim=nvim

# fzf configurations
eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="--tmux 80% --color=fg:#bdae93,bg:#1d2021,hl:#83a598
	--color=fg+:#ebdbb2,bg+:#bdae93,hl+:#83a598
	--color=border:#403d52,header:#83a598,gutter:#191724
	--color=spinner:#8ec07c,info:#fabd2f
	--color=pointer:#8ec07c,marker:#8ec07c,prompt:#fabd2f"
_fzf_compgen_path() {
  fd --hidden --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --exclude ".git" . "$1"
}

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree -color=always {} | head -200'"

_fzf_comprun() {
    local command=$1
    shift

    case "${command}" in
        cd)           fzf --preview 'eza --tree --color=always {} | head -200' "${@}" ;;
        export|unset) fzf --preview "eval 'echo \$'{}" "${@}" ;;
        ssh)          fzf --preview 'dig {}' "${@}" ;;
        *)            fzf --preview 'bat -n --color=always --line-range :500 {}' "${@}" ;;
    esac
}

# eza configurations
alias ls="eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(starship init zsh)"

# Completions
autoload -Uz compinit && compinit

if [ -z "$TMUX" ]
then
	tmux attach -t default || tmux new -s default
fi

# rust to path
export PATH="$(brew --prefix rustup)/bin:$PATH"
