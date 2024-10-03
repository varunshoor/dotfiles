# Direnv Setup
eval "$(direnv hook zsh)"

# Enable history so we get auto suggestions
export HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history" # History filepath
export HISTSIZE=100000                           # Maximum events remembered for internal history
export SAVEHIST=$HISTSIZE                        # Maximum events stored in history file

# Stop autocorrect from suggesting undesired completions
export CORRECT_IGNORE_FILE=".*"
export CORRECT_IGNORE="_*"

# Source the Env Variables from Home
source ~/.envrc
