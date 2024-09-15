# # Script to change kitty theme based on time of day
# getTimeOfDay() {
#   local current_hour=$(date +%H)
#   
#   if (( current_hour >= 6 && current_hour < 12 )); then
#     echo "morning"
#   elif (( current_hour >= 12 && current_hour < 18 )); then
#     echo "afternoon"
#   elif (( current_hour >= 18 && current_hour < 21 )); then
#     echo "evening"
#   else
#     echo "night"
#   fi
# }
#
# changeKittyTheme() {
#   local time_of_day=$(getTimeOfDay)
#   local time_of_day="morning" # Defaulting to dayfox for now
#   local kitty_theme=""
#   local current_theme_path="$HOME/.config/kitty/.currenttheme"
#
#   case $time_of_day in
#     morning|afternoon|evening)
#       kitty_theme="Dayfox"
#       ;;
#     night)
#       kitty_theme="Carbonfox"
#       ;;
#     *)
#       echo "Unknown time of day"
#       return
#       ;;
#   esac
#
#   if [[ -n "$kitty_theme" ]]; then
#     local last_theme=""
#     if [[ -f "$current_theme_path" ]]; then
#       last_theme=$(cat "$current_theme_path")
#     fi
#
#     if [[ "$last_theme" != "$kitty_theme" ]]; then
#       kitty +kitten themes --reload-in=all "$kitty_theme"
#       echo "$kitty_theme" > "$current_theme_path"
#     fi
#   fi
# }
#
# # Change Kitty theme on shell startup
# changeKittyTheme
#
# # Tmux Theme
# changeTmuxTheme() {
#   local time_of_day=$(getTimeOfDay)
#   local time_of_day="morning" # Default to dayfox for now
#   local tmux_theme=""
#
#   case $time_of_day in
#     morning)
#       tmux_theme="tmux.dayfox.conf"
#       ;;
#     afternoon)
#       tmux_theme="tmux.dayfox.conf"
#       ;;
#     evening)
#       tmux_theme="tmux.dayfox.conf"
#       ;;
#     night)
#       tmux_theme="tmux.darkplus.conf"
#       ;;
#     *)
#       echo "Unknown time of day"
#       return
#       ;;
#   esac
#
#   if [[ -n "$tmux_theme" ]]; then
#     tmux source-file "/Users/varunshoor/.config/tmux/$tmux_theme"
#   fi
# }
#
# changeTmuxTheme
