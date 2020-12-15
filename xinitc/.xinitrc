#!/bin/sh

# Script for switching caps with escape and increasing
# key rate delays
 keymap &

# Slstatus
 slstatus &

# Script for setting wallpaper
 setbg &

# Compositor
 xcompmgr &

# Uncomment to use Xresources colors/settings on startup
 xrdb ${XDG_CONFIG_HOME:-$HOME/.config}/Xresources &

# Wallpaper
# nitrogen --restore &

# Hide mouse pointer when idle for 5 seconds
 unclutter &

# Easy on the eyes
 redshift &

# Notification daemon
 dunst &

# Loop for DWM
# while true; do
#   dwm >/dev/null 2>&1
# done

# Execute DWM
 exec dwm
