#!/bin/bash

# See: https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)#updating-to-the-latest-release
yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
sudo /opt/homebrew/bin/yabai --load-sa
/opt/homebrew/bin/yabai --start-service
/opt/homebrew/bin/skhd --start-service
