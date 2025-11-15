# Allow build scripts to be referenced without being copied into the final image
ARG FEDORA_VERSION="${FEDORA_VERSION:-43}"
ARG VARIANT="latest"

FROM scratch AS ctx
COPY build_files /

FROM quay.io/fedora-ostree-desktops/base-atomic:${FEDORA_VERSION}

COPY system_files/ /
COPY system_files_headless/ /

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    echo "podman:65000:65536" >> /etc/subuid &&\
    echo "podman:65000:65536" >> /etc/subgid &&\
    dnf5 install -y NetworkManager-tui && \
    dnf5 remove -y firefox nano toolbox flatpak && \
    systemctl enable sshd && \
    /ctx/finalize
    
RUN bootc container lint
