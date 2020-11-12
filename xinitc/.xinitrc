#!/bin/sh

# Increase key speed via a rate change
 xset r rate 300 50

# Keyboard Remapping Caps with Escape
 setxkbmap -option caps:escape

# Slstatus
 slstatus &

# Compositor
 xcompmgr &

# Uncomment to use Xresources colors/settings on startup
  xrdb ${XDG_CONFIG_HOME:-$HOME/.config}/Xresources &

# Wallpaper
 nitrogen --restore &

# Hide mouse pointer when idle for 5 seconds
 unclutter &

# Easy on the eyes
 redshift &

# Loop for DWM
 while true; do
	dwm >/dev/null 2>&1
 done

# Execute DWM
 exec dwm
