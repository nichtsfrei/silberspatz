# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

FROM rust AS kanata
RUN git clone https://github.com/nichtsfrei/onscreenski.git
RUN mkdir /install/
WORKDIR onscreenski/backend
RUN make
RUN cp ukeynski /install/
WORKDIR ../frontend
RUN apt update && apt install -y \
    libgtk-4-dev \
    libgtk4-layer-shell-dev \
    libgraphene-1.0-dev
RUN cargo build --release
RUN cp target/release/onscreenski /install/


FROM ghcr.io/ublue-os/bazzite-deck-gnome:stable

COPY system_files/ /
COPY system_files_desktop/ /
COPY system_files_deck/ /

#TODO: remove yafti-go from bazzite-desktop-silverblue

COPY --from=kanata /install/ukeynski /usr/local/bin/ukeynski
COPY --from=kanata /install/onscreenski /usr/local/bin/onscreenski

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    VARIANT=$VARIANT /ctx/bazzite-changes.sh && \
    VARIANT=$VARIANT /ctx/build.sh && \
    /ctx/finalize

RUN bootc container lint
