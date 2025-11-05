ARG FEDORA_VERSION="${FEDORA_VERSION:-43}"

# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

#TODO: lookup ublue automount
# when I don't have my keyboard withme and using a laptop
FROM rust AS kanata
RUN cargo install kanata

FROM quay.io/fedora-ostree-desktops/silverblue:${FEDORA_VERSION}
 
COPY system_files/ /
COPY system_files_desktop/ /

COPY --from=kanata /usr/local/cargo/bin/kanata /usr/local/bin/kanata 

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh && \
    /ctx/finalize

RUN bootc container lint
