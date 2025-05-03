# syntax=docker/dockerfile:1
FROM python:3.13-slim

SHELL [ "/bin/bash", "-c" ]

ARG BUILD_DATE 
ARG VERSION
ARG UNIVERSAL_CALIBRE_VERSION=7.16.0

LABEL build_version="Version:- ${VERSION}" \
      build_date="${BUILD_DATE}" \
      maintainer="gelbphoenix"

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_ROOT_USER_ACTION=ignore \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_BREAK_SYSTEM_PACKAGES=1 \
    CALIBRE_DBPATH=/config \
    UMASK=0002

USER root

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      libldap2-dev \
      libsasl2-dev \
      curl \
      python3-dev \
      python3-pip \
      imagemagick \
      ghostscript \
      libldap-2.5-0 \
      libmagic1 \
      libsasl2-2 \
      libxi6 \
      libxslt1.1 \
      python3-venv \
      libxtst6 \
      libxrandr2 \
      libxkbfile1 \
      libxcomposite1 \
      libopengl0 \
      libnss3 \
      libxkbcommon0 \
      libegl1 \
      libxdamage1 \
      libgl1 \
      libglx-mesa0 \
      xz-utils

# Install Autocaliweb
COPY requirements.txt optional-requirements.txt /app/autocaliweb/

RUN cd /app/autocaliweb && \
    python3 -m venv venv && \
    ./venv/bin/python3 -m pip install -U pip wheel && \
    ./venv/bin/python3 -m pip install --find-links https://wheel-index.linuxserver.io/ubuntu/ -r \
    requirements.txt -r \
    optional-requirements.txt 

COPY . /app/autocaliweb/

# Install kepubify
RUN export KEPUBIFY_RELEASE=$(curl -s https://api.github.com/repos/pgaskin/kepubify/releases/latest | awk -F'"' '/tag_name/{print $4;exit}') && \
    curl -Lo /usr/bin/kepubify "https://github.com/pgaskin/kepubify/releases/download/${KEPUBIFY_RELEASE}/kepubify-linux-$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')" && \
    chmod +x /usr/bin/kepubify

# Install Calibre binaries
RUN mkdir -p /app/calibre && \
    curl -o /tmp/calibre.tar.xz -L https://download.calibre-ebook.com/${UNIVERSAL_CALIBRE_VERSION}/calibre-${UNIVERSAL_CALIBRE_VERSION}-$(uname -m | sed 's/x86_64/x86_64/;s/arm64/arm64/').txz && \
    tar xf /tmp/calibre.tar.xz -C /app/calibre && \
    rm /tmp/calibre.tar.xz

# Clean up
RUN apt-get purge -y \
    build-essential \
    libldap2-dev \
    libsasl2-dev \
    python3-dev && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
    /root/.cache

# add unrar
COPY --from=ghcr.io/linuxserver/unrar:latest /usr/bin/unrar-ubuntu /usr/bin/unrar 

# ports and volumes
EXPOSE 8083
VOLUME /config