#!/bin/bash

set -ouex pipefail

dnf5 install -y --setopt=install_weak_deps=False \
    cosmic-greeter \
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
	tuned \
	tuned-ppd \
	ntpd \
	swaylock

dnf5 copr enable -y avengemedia/dms
dnf5 install -y dms
dnf5 copr disable -y avengemedia/dms

dnf5 remove -y firefox nano toolbox 
