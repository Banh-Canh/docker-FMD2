## Descriptions

Dockerized FMD2 (Windows with Wine) using VNC, noVNC and webSocketify to display GUI on a webpage.

https://github.com/dazedcat19/FMD2

## Features:
* Does not require any display, works headless
* Keeps all of FMD2 features
* Since it's docker, it works on Linux
* Make use of Linuxserver alpine base image

## Docker
```yaml
---
version: "2.1"
services:
  fmd2:
    image: fmd2
    container_name: fmd2
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Paris
      - UMASK=022 #optional
    ports:
      - 6080:6080
    volumes:
      - /opt/docker-userdata/FMD2/config/userdata:/app/FMD2/userdata
      - /opt/docker-userdata/FMD2/config/modules:/app/FMD2/lua
      - /opt/docker-userdata/FMD2/config/data:/app/FMD2/data
      - /opt/docker-userdata/FMD2/config/wine:/wine
      - /mnt/DATA2/Bin:/downloads
    restart: unless-stopped
```

## License
[MIT](https://choosealicense.com/licenses/mit/)
