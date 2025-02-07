# syntax=docker/dockerfile:1

FROM debian:bookworm

ARG UID=1000
ARG GID=1000

RUN --mount=type=cache,target=/var/lib/apt/,sharing=locked \
    --mount=type=cache,target=/var/cache/apt/,sharing=locked \
    dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y --no-install-recommends \
    # For development
    sudo \
    # For run
    pulseaudio wine wine64 wine32:i386 fonts-dejavu-core fonts-freefont-ttf fonts-noto-cjk fonts-noto-color-emoji

RUN groupadd -g $GID debian \
    && useradd -m -s /bin/bash -u $UID -g $GID debian \
    && echo 'debian ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER debian

WORKDIR /app/

COPY AIVoice2Editor .
COPY entrypoint.sh .

ENTRYPOINT [ "./entrypoint.sh" ]
