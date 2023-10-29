#!/bin/sh
# xautolock -time 10 -locker slock
# xrandr --dpi 192	&	# Set DPI. User may want to use a larger number for larger screens.
keymap & # Script for switching/replacing capslock with escape and increasing key rate delays
xrdb -merge ~/.Xresources & # Adds display scaling and theme
# eval $(gnome-keyring-daemon --start)
# export SSH_AUTH_SOCK

/usr/bin/gnome-keyring-daemon --start --components=ssh &

setbg & # Script to set wallpaper on startup
dwmblocks &
redshift-gtk &
# peer2profit &
# xcompmgr &
picom &
lxpolkit &
unclutter &
dunst &
clipmenud &
# autostart="dwmblocks redshift peer2profit xcompmgr lxpolkit unclutter dunst clipmenud"
/usr/lib/kdeconnectd &
mailspring -b &
nm-applet &

# for program in $autostart; do
# 	pidof -s "$program" || setsid -f "$program"
# done >/dev/null 2>&1

# source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh &

systemctl --user import-environment DISPLAY XAUTHORITY

if command -v dbus-update-activation-environment >/dev/null 2>&1; then
    dbus-update-activation-environment DISPLAY XAUTHORITY
fi

# Loop for DWM
 while true; do
   dwm >/dev/null 2>&1
 done
exec dwm
