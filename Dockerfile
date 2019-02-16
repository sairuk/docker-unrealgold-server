FROM i386/debian:stretch-slim
MAINTAINER sairuk

# ENVIRONMENT
ARG SRVUSER=gameserv
ARG SRVUID=1000
ENV INSTDIR=/home/${SRVUSER}/unrealgold/

RUN apt-get update \
    && apt-get -y upgrade


# USER
# -- add server user
RUN useradd -m -s /bin/bash -u ${SRVUID} ${SRVUSER}


# APPLICATION
# -- unreal base server install --- no dedicated server release :/
COPY _vanillaserver/. /home/${SRVUSER}/
# -- default start-server script
COPY _scripts/start-server ${INSTDIR}/start-server
# -- update to custom configuration
COPY _custom/. ${INSTDIR}

RUN chmod +x ${INSTDIR}/start-server
RUN chown -R ${SRVUSER}: /home/gameserv/

# PORTS
EXPOSE \
# -- game port
7777/udp \
# -- query port
7778/udp \
# -- list on master server
27900/tcp

USER ${SRVUSER}
WORKDIR ${INSTDIR}

CMD ["./start-server"]
