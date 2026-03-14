#!/bin/bash

set -ouex pipefail

dnf5 install -y --setopt=install_weak_deps=False \
    niri

dnf5 install -y fish tmux neovim distrobox \
	pam-u2f pamu2fcfg pamtester \
	setroubleshoot \
	qemu-kvm \
	brightnessctl \
	btop \
	bat \
	ripgrep \
	fzf \
	flatpak \
	foot \
	fuzzel \
	gtk4-layer-shell \
	swaylock \
	tlp

dnf5 remove -y firefox nano toolbox
