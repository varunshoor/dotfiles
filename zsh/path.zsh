# Note: The first added entry gets referenced last

if command -v getconf &> /dev/null; then
  PATH="$(getconf PATH)"
fi

# Prepend PATH by skipping duplicates
declare -U PATH
prepend() {
  [ -d "$1" ] && PATH="$1:$PATH"
}

prepend "/usr/local/bin"
prepend "$HOME/.local/bin" # For pipx
prepend "$HOME/bin"

# Homebrew binaries
# > $(brew --prefix)
homebrew_path="/opt/homebrew"
prepend "$homebrew_path/bin"
prepend "$homebrew_path/sbin"

# fnm, Node version manager: https://github.com/Schniz/fnm
eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"

# Custom dotfiles binaries
prepend "$HOME/dotfiles/bin"

# User binaries
prepend "$HOME/bin"

# Add Python to $PATH
prepend "$(brew --prefix)/opt/python/libexec/bin"

# Add OpenJDK
prepend "/opt/homebrew/opt/openjdk/bin"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"

# ZLib
export LDFLAGS="-L/opt/homebrew/opt/zlib/lib"
export CPPFLAGS="-I/opt/homebrew/opt/zlib/include"

# PIPX
prepend "/Users/varunshoor/.local/bin"

# Go Binaries
prepend "$HOME/go/bin"

# Go Bin Setup
export GOBIN="/Users/varunshoor/go/bin"

# Cargo
prepend "$HOME/.cargo/bin"


# LazyGit
export XDG_CONFIG_HOME="$HOME/.config"

# Prevent it from being used accidentally elsewhere in the script or by other scripts
unset prepend

export PATH
