if [ -z "$TMUX" ]
then
    # tmux attach -t workspace || tmux new -s workspace
    tmuxinator start workspace
fi
