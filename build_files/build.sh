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
	swaylock

# try to get familiar with paperwm instead of tilingshell in bazzite
# On a gaming machine there is gamescope, while on non gaming machines the extra CPU usage is insignificant
dnf5 install -y \
    gnome-shell-extension-caffeine

dnf5 remove -y firefox nano toolbox
