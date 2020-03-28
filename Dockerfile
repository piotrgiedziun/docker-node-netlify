FROM node:13-stretch-slim

LABEL maintainer="piotrgiedziun@gmail.com"

RUN apt update \
    && apt install -y jq git \
    && rm -rf /var/lib/apt/lists/* \
    && npm -g install netlify-cli