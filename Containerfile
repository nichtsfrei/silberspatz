# Allow build scripts to be referenced without being copied into the final image
ARG FEDORA_VERSION="${FEDORA_VERSION:-42}"

FROM ghcr.io/ublue-os/akmods:bazzite-${FEDORA_VERSION} AS akmods
FROM ghcr.io/ublue-os/akmods-extra:bazzite-${FEDORA_VERSION} AS akmods-extra

FROM scratch AS ctx
COPY build_files /

FROM rust AS kanata
RUN cargo install kanata



# Base Image
#FROM ghcr.io/ublue-os/silverblue-main:latest
# FROM quay.io/fedora-ostree-desktops/kinoite:43
FROM quay.io/fedora-ostree-desktops/base-atomic:${FEDORA_VERSION}
ARG VARIANT="latest"
ENV VARIANT=${VARIANT}
 
COPY system_files/ /

RUN --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=tmpfs,dst=/tmp \
    mkdir -p /var/roothome && \
    dnf5 -y install dnf5-plugins && \
    for copr in \
        bazzite-org/bazzite \
        bazzite-org/bazzite-multilib; \
    do \
        echo "Enabling copr: $copr"; \
        dnf5 -y copr enable $copr; \
        dnf5 -y config-manager setopt copr:copr.fedorainfracloud.org:${copr////:}.priority=98 ;\
    done && unset -v copr && \
    dnf5 -y config-manager setopt "*bazzite*".priority=1 && \
    dnf5 -y config-manager setopt "*fedora*".exclude="mesa-* kernel-core-* kernel-modules-* kernel-uki-virt-*" && \
    /ctx/cleanup

# Setup firmware
RUN --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/install-firmware && \
    /ctx/cleanup

COPY --from=kanata /usr/local/cargo/bin/kanata /usr/local/bin/kanata 

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    VARIANT=$VARIANT /ctx/build.sh && \
    /ctx/finalize

    
RUN bootc container lint
