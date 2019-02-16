# Docker Unreal (Gold) Dedicated Server
32bit environment to run Unreal (Gold) within Docker, based on Debian Stretch-Slim.

## Information
There was no standalone dedicated server release for this title so I cannot create an installer in this release. 

You will need to have an existing server and place it in the _vanillaserver/unrealgold directory.

## Ports
Exposed ports to allow connections and communications with master servers
7777/udp 
7778/udp
27900/tcp

## Volumes
None

## Usage
**Build the image**

`docker build . -t unrealgold-server`

**Run a container**

NB: the `--rm` arg will destroy the container when stopped; internal ports (666) can be mapped to available host ports (27999) per container
```
docker run -d --rm \
-p 7777:7777/udp \
-p 7778:7778/udp \
-p 27900:27900/tcp \
--name unrealgold-server \
unrealgold-server:latest
```

**Stop container**

`docker stop unrealgold-server`


## Server Customization
You can customize the server at build time by dropping the appropriate files at the appropriate locations in `_custom/`, these will be copied into the image into the install location within the container at build time.

You can override the following defaults at build time
```
ARG SRVUSER=gameserv
ARG SRVUID=1000
```

You can also override the start-server script by added one to _custom this will overwrite the default at build time.
