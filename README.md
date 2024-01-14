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
version: "3"
services:
  fmd2:
    image: banhcanh/docker-fmd2:kasm-v2
    container_name: fmd2
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Paris
      - UMASK=022 #optional
    ports:
      - 3000:3000
    volumes:
      - ./tmp/FMD2/userdata:/app/FMD2/userdata
      - ./tmp/downloads:/downloads
    restart: unless-stopped
```

## Kubernetes

https://github.com/TKVH-Apps/fmd2

## License
[MIT](https://choosealicense.com/licenses/mit/)
