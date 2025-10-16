# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

FROM rust AS kanata
RUN cargo install kanata

# Base Image
#FROM ghcr.io/ublue-os/silverblue-main:latest
FROM quay.io/fedora-ostree-desktops/silverblue:42
# FROM quay.io/fedora-ostree-desktops/cosmic-atomic:43
 
COPY system_files/ /
COPY --from=kanata /usr/local/cargo/bin/kanata /usr/local/bin/kanata 

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh && \
    ostree container commit
    
### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
