ARG FEDORA_VERSION="${FEDORA_VERSION:-43}"

# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

#TODO: lookup ublue automount
# when I don't have my keyboard withme and using a laptop
FROM rust AS kanata
RUN cargo install kanata
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


FROM quay.io/fedora-ostree-desktops/silverblue:${FEDORA_VERSION}
 
COPY system_files/ /
COPY system_files_desktop/ /

COPY --from=kanata /usr/local/cargo/bin/kanata /usr/local/bin/kanata 
COPY --from=kanata /install/ukeynski /usr/local/bin/ukeynski
COPY --from=kanata /install/onscreenski /usr/local/bin/onscreenski

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    dnf5 -y copr enable sukhmeet/RyzenAdj && \
    dnf5 install -y ryzenadj && \
    dnf5 -y copr disable sukhmeet/RyzenAdj && \
    /ctx/build.sh && \
    /ctx/finalize

RUN bootc container lint
