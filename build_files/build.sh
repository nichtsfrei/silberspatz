#!/bin/bash

set -ouex pipefail

dnf5 install -y --setopt=install_weak_deps=False \
	niri \
	squeekboard \
	foot \
	swaylock \
	swayidle \
	cosmic-app-library

dnf5 install -y fish tmux neovim distrobox \
	NetworkManager-tui \
	pam-u2f pamu2fcfg pamtester \
	setroubleshoot \
	@virtualization \
	just \
	brightnessctl \
	flatpak

dnf5 remove -y firefox nano
