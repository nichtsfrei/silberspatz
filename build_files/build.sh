#!/bin/bash

set -ouex pipefail

dnf5 install -y --setopt=install_weak_deps=False \
    niri

dnf5 install -y fish tmux neovim distrobox \
	NetworkManager-openconnect \
	pam-u2f pamu2fcfg pamtester \
	setroubleshoot \
	qemu-kvm \
	brightnessctl \
	btop \
	bat \
	ripgrep \
	fzf \
	foot \
	fd-find \
	flatpak \
	fuzzel \
	gtk4-layer-shell \
	tuned \
	tuned-ppd \
	ntpd \
	swaylock

dnf5 remove -y firefox nano toolbox 
