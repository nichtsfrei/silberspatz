#!/bin/bash

set -ouex pipefail

dnf5 install -y --setopt=install_weak_deps=False \
    niri

dnf5 install -y fish tmux neovim distrobox \
	NetworkManager-tui \
	pam-u2f pamu2fcfg pamtester \
	setroubleshoot \
	qemu-kvm \
	brightnessctl \
	btop \
	ripgrep \
	fzf \
	flatpak \
	foot \
	fuzzel \
	gtk4-layer-shell \
	swaylock \
	waybar

dnf5 remove -y firefox nano toolbox
