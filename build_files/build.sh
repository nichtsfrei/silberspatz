#!/bin/bash

set -ouex pipefail

dnf5 install -y fish tmux neovim distrobox \
	NetworkManager-tui \
	pam-u2f pamu2fcfg pamtester \
	setroubleshoot \
	@virtualization \
	just \
	brightnessctl \
	flatpak \
	niri

dnf5 remove -y firefox nano
