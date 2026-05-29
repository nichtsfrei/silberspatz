ARG FEDORA_VERSION="${FEDORA_VERSION:-44}"

# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Build kanata and ashell without onscreenski
FROM rust AS kanata
RUN cargo install kanata
#RUN cargo install television

RUN mkdir /install/
RUN apt update && apt install -y \
     wayland-protocols \
      clang \
      libxkbcommon-dev \
      libwayland-dev \
      libdbus-1-dev \
      libpipewire-0.3-dev \
      libpulse-dev \
      libudev-dev
RUN cargo install --git https://github.com/itsjunetime/tdf.git

#FROM quay.io/fedora-ostree-desktops/base-atomic:${FEDORA_VERSION}
FROM quay.io/fedora-ostree-desktops/silverblue:${FEDORA_VERSION}
#FROM quay.io/fedora-ostree-desktops/kinoite:${FEDORA_VERSION}

COPY system_files/ /

COPY --from=kanata /usr/local/cargo/bin/kanata /usr/local/bin/kanata
COPY --from=kanata /usr/local/cargo/bin/tdf /usr/local/bin/tdf

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    dnf5 install -y NetworkManager-tui && \
    /ctx/build.sh && \
    /ctx/finalize

RUN bootc container lint
