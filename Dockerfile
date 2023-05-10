FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

LABEL \
  maintainer="vhvictorhang@gmail.com"

ENV \
  DISPLAY=:1 \
  WINEDLLOVERRIDES="mscoree,mshtml=" \
  HOME=/config

RUN \
  apt update && \
  apt install -y dpkg && \
  echo "Install Wine and its dependencies" && \
  dpkg --add-architecture i386 && \
  apt install -y wine64 && \
#  ln -s /usr/bin/wine64 /usr/bin/wine && \
  echo "Install required tools" && \
  apt install -y wget p7zip-full curl

ADD https://api.github.com/repos/dazedcat19/FMD2/releases/latest version.json

RUN curl -s https://api.github.com/repos/dazedcat19/FMD2/releases/latest | grep "browser_download_url.*download.*fmd.*64-win64.7z" | cut -d : -f 2,3 | tr -d '"' | wget -qi - -O FMD2.7z && \
  echo "Install FMD2" && \
  7z x FMD2.7z -o/app/FMD2 && \
  mkdir /downloads && \
  chown abc:abc -R /downloads && \
  mkdir -p /app/FMD2/userdata

# Copy my settings preset
COPY settings.json /app/FMD2/userdata/settings.json
COPY fmd2.sh /

# Create necessary folders and symlink novnc html so it opens directly on the right page
RUN \
  mkdir -p /app/FMD2/userdata && \
  chown abc:abc /app/FMD2 -R && \
  mkdir -p /root/defaults && \
  echo "wine64 /app/FMD2/fmd.exe" > /root/defaults/autostart

RUN \
  echo "Remove tools" && \
  rm FMD2.7z && \
  apt autoremove -y p7zip-full wget curl --purge

VOLUME /config
EXPOSE 3000
