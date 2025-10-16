#!/bin/bash

set -ouex pipefail

# maybe install niri without recommendations
# I don't use alacritty

dnf5 install -y fish tmux neovim distrobox \
	pam-u2f pamu2fcfg pamtester \
	setroubleshoot \
	@virtualization \
	just \
	brightnessctl

dnf5 remove -y firefox nano
