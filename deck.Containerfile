# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

FROM ghcr.io/ublue-os/bazzite-deck-gnome:stable

COPY system_files/ /

#TODO: remove yafti-go from bazzite-desktop-silverblue

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    VARIANT=$VARIANT /ctx/bazzite-changes.sh && \
    VARIANT=$VARIANT /ctx/build.sh && \
    /ctx/finalize

RUN bootc container lint
