export TERM="xterm-256color"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Enable color output for CLI tools like ls and grep
export CLICOLOR=1

# BAT (cat replacement)
export BAT_THEME="Dracula"

# Customize LS colors
# Used by: ls, fd
LS_COLORS=""
LS_COLORS+="di=34;;1:" # Directories
LS_COLORS+="ex=33:"    # Executable files
LS_COLORS+="ln=36:"    # Symlinks
LS_COLORS+="or=31:"    # Broken symlinks
export LS_COLORS

# Eza colors: https://github.com/eza-community/eza/blob/main/man/eza_colors.5.md
EZA_COLORS="reset:$LS_COLORS"                      # Reset default colors, like making everything yellow
EZA_COLORS+="da=36:"                               # Timestamps
EZA_COLORS+="ur=0:uw=0:ux=0:ue=0:"                 # User permissions
EZA_COLORS+="gr=0:gw=0:gx=0:"                      # Group permissions
EZA_COLORS+="tr=0:tw=0:tx=0:"                      # Other permissions
EZA_COLORS+="xa=0:"                                # Extended attribute marker ('@')
EZA_COLORS+="xx=38;5;240:"                         # Punctuation ('-')
EZA_COLORS+="nb=38;5;240:"                         # Files under 1 KB
EZA_COLORS+="nk=0:"                                # Files under 1 MB
EZA_COLORS+="nm=37:"                               # Files under 1 GB
EZA_COLORS+="ng=38;5;250:"                         # Files under 1 TB
EZA_COLORS+="nt=38;5;255:"                         # Files over 1 TB
EZA_COLORS+="do=32:*.md=32:"                       # Documents
EZA_COLORS+="co=35:*.zip=35:"                      # Archives
EZA_COLORS+="tm=38;5;242:cm=38;5;242:.*=38;5;242:" # Hidden and temporary files
export EZA_COLORS
