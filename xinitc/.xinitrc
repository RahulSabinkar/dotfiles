#!/bin/sh
# xautolock -time 10 -locker slock
keymap & # Script for switching caps with escape and increasing key rate delays
setbg & # Script to set wallpaper on startup
lxsession & # Gtk Polkit Authentication Agent
xcompmgr & # Lightweight Compositor
# picom &
unclutter & # Hide mouse pointer when idle for 5 seconds
redshift & # Reduces eye strain by slightly changing display colors
dunst & # Notification daemon
clipmenud &
transmission-daemon &
#slstatus &
dwmblocks &
# Loop for DWM
 # while true; do
 #   dwm >/dev/null 2>&1
 # done
exec dwm
