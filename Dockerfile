FROM ghcr.io/linuxserver/baseimage-alpine:3.13

LABEL \
  maintainer="TKVictor-Hang@outlook.fr"

ENV \
  DISPLAY=:1 \
  WINEDLLOVERRIDES="mscoree,mshtml=" \
  HOME=/config

RUN \
  apk update && \
  apk add dpkg --no-cache && \
  echo "Install Wine and its dependencies" && \
  dpkg --add-architecture i386 && \
  apk update && apk add --no-cache wine && \
  ln -s /usr/bin/wine64 /usr/bin/wine && \

  echo "Install required tools" && \
  apk add --no-cache sudo wget p7zip curl && \
  echo "Install vnc, novnc, websockify to move the gui accessible with the browser" && \
  apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing \
  novnc websockify && \
  apk add --no-cache xvfb x11vnc fluxbox

ADD https://api.github.com/repos/dazedcat19/FMD2/releases/latest version.json

RUN curl -s https://api.github.com/repos/dazedcat19/FMD2/releases/latest | grep "browser_download_url.*download.*fmd.*64-win64.7z" | cut -d : -f 2,3 | tr -d '"' | wget -qi - -O FMD2.7z && \

  echo "Install FMD2" && \
  7z x FMD2.7z -o/app/FMD2 && \
  mkdir /downloads && \
  chown abc:abc -R /downloads && \

## Adjust noVNC windows
  rm /usr/share/novnc/vnc.html && \
  mv /usr/share/novnc/vnc_lite.html /usr/share/novnc/index.html && \
  curl https://raw.githubusercontent.com/novnc/noVNC/master/vnc_lite.html > /usr/share/novnc/index.html && \
  sed -i '42s/.*/display:none;/' /usr/share/novnc/index.html && \
  sed -i '50s/.*/display:none;/' /usr/share/novnc/index.html && \
  sed -i '169s/.*/rfb.scaleViewport = readQueryVariable("scale", true);/' /usr/share/novnc/index.html

# Copy my settings preset
COPY settings.json /
COPY fmd2.sh /
COPY fluxbox /fluxbox

# Create necessary folders and symlink novnc html so it opens directly on the right page
RUN \
  mkdir /app/FMD2/userdata && \
  chown abc:abc /app/FMD2 -R

COPY root/ /

RUN \
  echo "Remove tools" && \
  rm FMD2.7z && \
  apk del p7zip wget curl --purge

VOLUME /config
EXPOSE 6080
