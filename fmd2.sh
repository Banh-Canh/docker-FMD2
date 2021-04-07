#!/bin/bash
Xvfb :1 -screen 0 1920x1080x24 -listen tcp -ac &
x11vnc -display :1 -noipv6 -reopen -forever -repeat -shared -rfbport 5900 -noxdamage -bg &
websockify -D --web=/usr/share/novnc/ 6080 localhost:5900 &
fluxbox &
wineserver -k
wine /app/FMD2/fmd.exe
