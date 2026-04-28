FROM ubuntu:noble

ARG GODOT_VERSION=4.6.2
ARG GODOT_STATUS=stable
ARG GODOT_PLATFORM=linux.x86_64
ARG GODOT_DOWNLOAD_PLATFORM=linux.64
ARG BUTLER_PLATFORM=linux-amd64

ENV DEBIAN_FRONTEND=noninteractive
ENV GODOT_TEMPLATES_DIR=/root/.local/share/godot/export_templates/${GODOT_VERSION}.${GODOT_STATUS}

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        libfontconfig1 \
        libfreetype6 \
        libgl1 \
        libx11-6 \
        libxcursor1 \
        libxext6 \
        libxfixes3 \
        libxi6 \
        libxinerama1 \
        libxrandr2 \
        unzip \
        wget \
        git \
        git-lfs \
        zip \
    && rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    mkdir -p /opt/godot; \
    wget -O /tmp/godot.zip "https://downloads.godotengine.org/?version=${GODOT_VERSION}&flavor=${GODOT_STATUS}&slug=${GODOT_PLATFORM}.zip&platform=${GODOT_DOWNLOAD_PLATFORM}"; \
    unzip -q /tmp/godot.zip -d /opt/godot; \
    mv "/opt/godot/Godot_v${GODOT_VERSION}-${GODOT_STATUS}_${GODOT_PLATFORM}" /opt/godot/godot; \
    chmod +x /opt/godot/godot; \
    ln -s /opt/godot/godot /usr/local/bin/godot; \
    rm /tmp/godot.zip

RUN set -eux; \
    mkdir -p "${GODOT_TEMPLATES_DIR}" /tmp/godot-templates; \
    wget -O /tmp/godot_export_templates.tpz "https://downloads.godotengine.org/?version=${GODOT_VERSION}&flavor=${GODOT_STATUS}&slug=export_templates.tpz&platform=templates"; \
    unzip -q /tmp/godot_export_templates.tpz -d /tmp/godot-templates; \
    mv /tmp/godot-templates/templates/* "${GODOT_TEMPLATES_DIR}/"; \
    test -f "${GODOT_TEMPLATES_DIR}/version.txt"; \
    rm -rf /tmp/godot_export_templates.tpz /tmp/godot-templates

RUN set -eux; \
    mkdir -p /opt/butler; \
    wget -O /tmp/butler.zip "https://broth.itch.zone/butler/${BUTLER_PLATFORM}/LATEST/archive.zip"; \
    unzip -q /tmp/butler.zip -d /opt/butler; \
    chmod +x /opt/butler/butler; \
    ln -s /opt/butler/butler /usr/local/bin/butler; \
    rm /tmp/butler.zip

WORKDIR /workspace

RUN godot --headless --version
RUN butler version
