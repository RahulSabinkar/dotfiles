#!/bin/sh
# xautolock -time 10 -locker slock
keymap & # Script for switching caps with escape and increasing key rate delays
setbg & # Script to set wallpaper on startup
#lxsession & # Gtk Polkit Authentication Agent
#volumeicon & # Volume Tray
slstatus &
xcompmgr & # Lightweight Compositor
# xrdb ${XDG_CONFIG_HOME:-$HOME/.config}/Xresources &
# nitrogen --restore &
unclutter & # Hide mouse pointer when idle for 5 seconds
redshift & # Reduces eye strain by slightly changing display colors
dunst & # Notification daemon
# Loop for DWM
 # while true; do
 #   dwm >/dev/null 2>&1
 # done
exec dwm
