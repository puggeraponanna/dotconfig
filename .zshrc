export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"

export PATH="/opt/homebrew/opt/llvm@12/bin:$PATH"

alias vim=nvim
export EDITOR=nvim

# opam configuration
[[ ! -r /Users/ponanna/.opam/opam-init/init.zsh ]] || source /Users/ponanna/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.3

# fzf configurations
eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="--tmux 80% --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 --color=selected-bg:#45475a --color=border:#313244,label:#cdd6f4"
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
