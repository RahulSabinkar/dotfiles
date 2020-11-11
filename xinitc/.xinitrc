#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Increase key speed via a rate change
 xset r rate 300 50

# Keyboard Remapping Caps with Escape
 setxkbmap -option caps:escape

# Slstatus
 slstatus &

# Compositor
 xcompmgr &

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
