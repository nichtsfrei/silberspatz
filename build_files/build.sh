#!/bin/bash

set -ouex pipefail

dnf5 install -y fish tmux neovim distrobox \
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
