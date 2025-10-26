#!/bin/sh

set -ouex pipefail
dnf5 -y remove \
    twitter-twemoji-fonts \
    google-noto-sans-cjk-fonts \
    lato-fonts \
    fira-code-fonts \
    nerd-fonts \
    sunshine \
    tailscale \
    gum \
    cockpit-networkmanager \
    cockpit-podman \
    cockpit-selinux \
    cockpit-system \
    cockpit-navigator \
    cockpit-storaged \
    stress-ng \
    nautilus-gsconnect \
    gnome-shell-extension-blur-my-shell \
    gnome-shell-extension-restart-to \
    gnome-shell-extension-hotedge \
    gnome-shell-extension-appindicator \
    gnome-shell-extension-user-theme \
    gnome-shell-extension-gsconnect \
    gnome-shell-extension-compiz-windows-effect \
    gnome-shell-extension-compiz-alike-magic-lamp-effect \
    gnome-shell-extension-just-perfection \
    gnome-shell-extension-hanabi \
    gnome-shell-extension-bazzite-menu \
    gnome-shell-extension-burn-my-windows \
    gnome-shell-extension-desktop-cube \
    ublue-brew \
    just # I kind of like it, but I still prefer shell scripts that I control, for now.

rm -rf \
    /bin/yafti-go /usr/libexec/bazzite-yafti-launcher \
    /usr/share/gnome-shell/extensions/tilingshell@ferrarodomenico.com \
    /usr/bin/ujust-picker /usr/share/ublue-os/just \
    /usr/share/ublue-os/bazaar \
    /usr/share/ublue-os/justfile 


