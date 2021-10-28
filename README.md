## Descriptions

Dockerized FMD2 (Windows with Wine) using VNC, noVNC and webSocketify to display GUI on a webpage.

https://github.com/dazedcat19/FMD2

https://hub.docker.com/r/banhcanh/docker-fmd2

Make sure to configure it using the 'web' ui.

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
    image: banhcanh/docker-fmd2
    container_name: fmd2
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Paris
      - UMASK=022 #optional
    ports:
      - 6080:6080
    volumes:
      - /path/to/FMD2/userdata:/app/FMD2/userdata
      - /path/to/FMD2/modules:/app/FMD2/lua
      - /path/to/FMD2/data:/app/FMD2/data
      - /path/to/wine/data:/config/.wine
      - /path/to/downloads:/downloads
    restart: unless-stopped
```

## Kubernetes

https://github.com/TKVH-Apps/fmd2

## License
[MIT](https://choosealicense.com/licenses/mit/)
