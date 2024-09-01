FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntunoble

ARG FMD2_VERSION="2.0.32.0"

LABEL \
  maintainer="vhvictorhang@gmail.com"

ENV \
  WINEDLLOVERRIDES="mscoree,mshtml=" \
  HOME=/config

RUN \
  apt update && \
  apt install -y dpkg && \
  dpkg --add-architecture i386 && \
  apt install -y wine64=9.0~repack-4build3 wget p7zip-full curl git python3-pyxdg inotify-tools rsync &&\
  curl -s https://api.github.com/repos/dazedcat19/FMD2/releases/tags/${FMD2_VERSION} | grep "browser_download_url.*download.*fmd.*x86_64.*.7z" | cut -d : -f 2,3 | tr -d '"' | wget -qi - -O FMD2.7z && \
  7z x FMD2.7z -o/app/FMD2 && \
  rm FMD2.7z && \
  apt autoremove -y p7zip-full wget curl --purge && \
  mkdir /downloads && \
  mkdir -p /app/FMD2/userdata && \
  mkdir -p /app/FMD2/downloads

# Copy my settings preset
COPY settings.json root /

VOLUME /config
EXPOSE 3000
