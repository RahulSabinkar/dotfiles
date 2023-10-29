#!/bin/sh
eval "export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $LOGNAME gnome-session)/environ)";

#Code:
DISPLAY=:0 notify-send "Test"
