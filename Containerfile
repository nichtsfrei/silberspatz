# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

FROM rust:latest AS cosmic-niri
RUN apt update && apt install -y git just
WORKDIR /
RUN mkdir -p /install/usr/share/wayland-sessions/
RUN mkdir -p /install/usr/local/bin
RUN git clone https://github.com/Drakulix/cosmic-ext-extra-sessions.git
WORKDIR cosmic-ext-extra-sessions
RUN git submodule update --init
RUN just build
RUN mv cosmic-ext-alternative-startup/target/release/cosmic-ext-alternative-startup /install/usr/local/bin/
RUN mv niri/cosmic-ext-niri.desktop /install/usr/share/wayland-sessions/
RUN mv niri/start-cosmic-ext-niri /install/usr/local/bin/

# Base Image
#FROM ghcr.io/ublue-os/silverblue-main:latest
#FROM quay.io/fedora-ostree-desktops/silverblue:43
FROM quay.io/fedora-ostree-desktops/cosmic-atomic:43
 
# ... and so on, here are more base images
# Universal Blue Images: https://github.com/orgs/ublue-os/packages
# Fedora base image: quay.io/fedora/fedora-bootc:41
# CentOS base images: quay.io/centos-bootc/centos-bootc:stream10

### MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.
COPY system_files/ /
COPY --from=cosmic-niri /install /

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh && \
    ostree container commit
    
### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
