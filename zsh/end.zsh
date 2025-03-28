if [ -z "$TMUX" ]
then
    # tmux attach -t workspace || tmux new -s workspace
    tmuxinator start workspace
fi

# Load yabai
sudo yabai --load-sa
yabai --start-service
skhd --start-service
