#!/bin/bash

set -ouex pipefail

dnf5 install -y fish neovim distrobox \
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
	gtk4-layer-shell \
	mutter-devel \
	dbus-run-session \
	tuned \
	tuned-ppd \
	ntpd \

dnf5 remove -y firefox nano toolbox plymouth evolution ptyxis
