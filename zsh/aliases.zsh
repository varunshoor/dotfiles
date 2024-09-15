# TIP: for a full list of active aliases, run `alias

# Tmux
alias mux="tmuxinator"

# CUSTOM TMUX ALIASES
# tat: tmux attach
function tat {
  name=$(basename `pwd` | sed -e 's/\.//g')

  if tmux ls 2>&1 | grep "$name"; then
    tmux attach -t "$name"
  elif [ -f .envrc ]; then
    direnv exec / tmux new-session -s "$name"
  else
    tmux new-session -s "$name"
  fi
}

# Attaches tmux to a session (example: ta portal)
alias ta='tmux attach -+'
# Creates a new session
alias tn='tmux new-session -s'
# Kill session
alias tk='tmux kill-session -t'
# Lists all ongoing sessions alias tie'tmux list-sessions'
# Detach from session
alias td='tmux detach'
# Tux Clear pane
alias tc='clear; tmux clear-history; clear'

# Enable aliases to be sudo’ed
alias sudo="sudo "

# Easier navigation
alias .='pwd'
alias ..='cd ..'
alias ...="cd ../..;"
alias ....="cd ../../..;"
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'
alias cd..='cd ..'
alias -- -="cd -" # previous working directory

# Hot-access directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias projects="cd $WORKSPACE"

# zshrc config
alias zshrc="$EDITOR ~/.zshrc"
alias reload="source ~/.zshrc && echo 'Shell config reloaded from ~/.zshrc'"
alias s="reload"

# Sane defaults for built-ins (verbose and interactive)
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias grep="grep -i --color=auto"
alias mkdir="mkdir -p"

# Shortcuts
alias o="open"
alias oo="open ."
alias g="git"
alias d="docker"
alias dc="docker-compose"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias where="which"
alias p="pnpm"
alias nvm="fnm"

# Apps

# Lazydocker
alias ld="lazydocker"

# Lazygit
alias lg="lazygit --use-config-dir $DOTFILES/lazygit"

# File Manager
alias nn="open -a 'Marta' ."

#
# Built-ins upgrades
#

command_exists() {
  command -v "$@" &> /dev/null
}

# Bat: https://github.com/sharkdp/bat
command_exists bat && alias cat="bat --style=plain"

# Fd: https://github.com/sharkdp/fd
command_exists fd && alias find="fd"

# Eza: https://eza.rocks/
# Display all clickable entries (incl. hidden files) as a grid with icons
command_exists eza && alias ls="eza -a --hyperlink --icons=auto --group-directories-first --color-scale-mode=fixed -g --time-style=long-iso"
# Display a detailed list of clickable entries (incl. hidden files) with a Git status
command_exists eza && alias ll="ls --long --no-user --header -g --git"
# Display clickable directory tree
command_exists eza && alias llt="ls --tree --git-ignore"
command_exists eza && alias tree="llt"
command_exists eza && alias la="eza --long --all --group --icons"

# Htop: https://htop.dev/
command_exists htop && alias top="htop"

# Tlrc: https://github.com/tldr-pages/tlrc
command_exists tldr && alias man="tldr --config ~/.tlrc.toml"

# Prettyping: https://denilson.sa.nom.br/prettyping/
command_exists prettyping && alias ping="prettyping --nolegend"

# Download file and save it with the name of the remote file in the current working directory
# Usage: get <URL>
alias get="curl -O -L"

#
# Helpers
#

# Most used Git shortcuts
alias gs="git rev-parse --git-dir > /dev/null 2>&1 && git status || ls"
alias gss="git rev-parse --git-dir > /dev/null 2>&1 && git status -sb || ls"
alias gd="git diff"
alias gp="pull --recurse-submodules"
alias gl="git log --graph --pretty=format:'%C(magenta)%h%Creset%C(auto)%d%Creset %s %C(blue bold)— %cr ~ %an%Creset'"
alias gpu="push"
alias gpuf="push --force-with-lease"
alias gfp='git checkout main && git fetch --prune && git pull --rebase'

# Preview and open files in the current dir
command_exists fzf && command_exists bat && alias preview="fzf --preview 'bat --color \"always\" {}'"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Cd to the root directory of the current Git repository
alias gitroot='cd "$(git rev-parse --show-toplevel)"'
alias gr="gitroot"

# Cd into the directory shown by the front-most Finder window
# Based on https://scriptingosx.com/2017/02/terminal-finder-interaction/
cdf() {
  cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
}

# Make a new directory and cd into it
take() {
  \mkdir -p "$1" && cd "$1"
}

# git clone and cd to a repo directory
clonecd() {
  git clone "$@"

  if [ "$2" ]; then
    cd "$2"
  else
    cd $(basename "$1" .git)
  fi

  if [[ -r "./yarn.lock" ]]; then
    yarn
  elif [[ -r "./pnpm-lock.yaml" ]]; then
    pnpm install
  elif [[ -r "./package-lock.json" ]]; then
    npm install
  fi
}
