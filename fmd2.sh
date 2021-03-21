#!/bin/bash
Xvfb :1 -screen 0 1600x900x24 &
x11vnc -display :1 -noipv6 -reopen -forever -repeat -loop -rfbport 5900 -noxdamage &
websockify -D --web=/usr/share/novnc/ 6080 localhost:5900 &
wine /app/FMD2/fmd.exe
