#!/bin/sh
# xautolock -time 10 -locker slock
xrandr --dpi 96		# Set DPI. User may want to use a larger number for larger screens.
setbg & # Script to set wallpaper on startup
keymap & # Script for switching/replacing capslock with escape and increasing key rate delays
#xrdb ~/.Xresources & # Adds theme

autostart="dwmblocks redshift peer2profit xcompmgr lxpolkit unclutter dunst clipmenud /usr/lib/kdeconnectd"

for program in $autostart; do
	pidof -s "$program" || setsid -f "$program"
done >/dev/null 2>&1

# Loop for DWM
 while true; do
   dwm >/dev/null 2>&1
 done
exec dwm
