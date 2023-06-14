FROM ubuntu:22.04

LABEL SOFTWARE_NAME ubuntu 22.04
LABEL MAINTAINER "Tom Harrop"

LABEL version=v1.0.0

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C

RUN     apt-get clean && \
        rm -r /var/lib/apt/lists/*

RUN     apt-get update && apt-get upgrade -y --fix-missing

RUN     apt-get update && apt-get install -y  --no-install-recommends \
            ca-certificates \
            wget

COPY    VERSION /app/VERSION

RUN     export VERSION=$(cat /app/VERSION) && \
        export TAG="$(expr "$VERSION" : '\([^_]*\)')" && \
        wget -O /usr/local/bin/get_blunted \
            "https://github.com/vgteam/GetBlunted/releases/download/${TAG}/get_blunted" && \
        chmod 755 /usr/local/bin/get_blunted


ENTRYPOINT ["/usr/local/bin/get_blunted"]
