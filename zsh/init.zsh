# Core Variables
export DOTFILES="~/dotfiles"
export WORKSPACE="~/bottomline"
export EDITOR="nvim"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# ATUIN
zinit light atuinsh/atuin

# AUTOSUGGESTIONS, TRIGGER PRECMD HOOK UPON LOAD
# The order is important, this should appear after atuin loading
ZSH_AUTOSUGGEST_STRATEGY=history
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#837a72"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
zinit ice wait="0a" lucid atload="_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

# HISTORY SUBSTRING SEARCHING
zinit ice wait"0b" lucid atload'bindkey "$terminfo[kcud1]" history-substring-search-down'
zinit light zsh-users/zsh-history-substring-search

# Don't bind Up Arrow - reserved for Atuin
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# ENHANCD
# zinit ice wait="0b" lucid
# zinit light b4b4r07/enhancd
# export ENHANCD_FILTER=fzf:fzy:peco
# Temporarily commented as it was interfering with cd ..

# TAB COMPLETIONS
zinit ice wait="0b" lucid blockf
zinit light zsh-users/zsh-completions
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '-- %d --'
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:complete:*:options' sort false
zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# FZF-TAB
zinit ice wait="1" lucid
zinit light Aloxaf/fzf-tab

# ZOXIDE
zinit ice wait="0" lucid from="gh-r" as="program" pick="zoxide-*/zoxide -> zoxide" cp="zoxide-*/completions/_zoxide -> _zoxide" atclone="./zoxide init zsh > init.zsh" atpull="%atclone" src="init.zsh"
zinit light ajeetdsouza/zoxide

# SYNTAX HIGHLIGHTING
zinit ice wait="0c" lucid atinit="zpcompinit;zpcdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting

# BAT-EXTRAS
zinit ice lucid wait="1" as="program" pick="src/batgrep.sh"
zinit ice lucid wait="1" as="program" pick="src/batdiff.sh"
zinit light eth-p/bat-extras
alias rg=batgrep.sh
alias bd=batdiff.sh
alias man=batman.sh

# zsh-autopair
zinit ice wait lucid
zinit load hlissner/zsh-autopair

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::rust
zinit snippet OMZP::command-not-found
zinit snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh
zinit snippet OMZP::gcloud
zinit snippet OMZP::npm
zinit snippet OMZP::node
zinit snippet OMZP::golang
zinit snippet OMZP::gradle
zinit snippet OMZP::terraform
zinit snippet OMZP::gh
zinit snippet OMZP::microk8s
zinit snippet OMZP::minikube
zinit snippet OMZP::nats
zinit snippet OMZP::postgres
zinit snippet OMZP::react-native
zinit snippet OMZP::tmuxinator
zinit snippet OMZP::tmux
zinit snippet OMZP::pip
zinit snippet OMZP::sudo
zinit snippet OMZP::doctl
zinit snippet OMZP::fnm

# Causes
# Error: The compinit function hasn't been loaded, cannot do compdef replay.
# zinit ice atload"zpcdreplay" atclone"./zplug.zsh" atpull"%atclone"
# zinit light g-plane/pnpm-shell-completion
