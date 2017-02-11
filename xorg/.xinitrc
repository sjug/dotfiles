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

# Set up screens and set background
if [ `xrandr | grep -c ' connected '` -eq 2 ]; then # dual-monitor
    if [ `xrandr | grep -w DP1 | grep -c ' connected '` -eq 1 ]; then
        xrandr --output eDP1 --auto --primary --output DP1 --auto --above eDP1
    fi
    feh --bg-tile ~/images/wallpapers/tile8.jpg
else
    xrandr --output eDP1 --auto --primary --output DP1 --off
    feh --bg-center ~/images/wallpapers/paperart5.jpg
fi

exec i3
