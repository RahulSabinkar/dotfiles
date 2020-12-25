#!/bin/sh
# xautolock -time 10 -locker slock
setbg &
keymap & # Script for switching caps with escape and increasing key rate delays
lxsession & # Authentication Agent
volumeicon &
slstatus &
xcompmgr &
# xrdb ${XDG_CONFIG_HOME:-$HOME/.config}/Xresources &
# nitrogen --restore &
unclutter & # Hide mouse pointer when idle for 5 seconds
redshift &
dunst & # Notification daemon
# Loop for DWM
 # while true; do
 #   dwm >/dev/null 2>&1
 # done
exec dwm
