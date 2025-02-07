FROM debian:bookworm

ARG UID=1000
ARG GID=1000

RUN --mount=type=cache,target=/var/lib/apt/,sharing=locked \
    --mount=type=cache,target=/var/cache/apt/,sharing=locked \
    sed -i 's/^Components: main$/& contrib non-free/' /etc/apt/sources.list.d/debian.sources && \
    dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y --no-install-recommends \
    # For development
    sudo \
    # For run
    ca-certificates task-japanese locales pulseaudio mesa-utils wine wine64 wine32:i386 winetricks ibus-mozc mozc-utils-gui fonts-noto-cjk

RUN sed -i -e 's/# \(ja_JP.UTF-8\)/\1/' /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=ja_JP.UTF-8

RUN groupadd -g $GID debian \
    && useradd -m -s /bin/bash -u $UID -g $GID debian \
    && echo 'debian ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER debian

WORKDIR /app/

COPY AIVoice2Editor .
COPY entrypoint.sh .

ENTRYPOINT [ "./entrypoint.sh" ]
