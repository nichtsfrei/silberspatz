#!/bin/bash

set -ouex pipefail

#TODO: find a better alternative to fuzzel,
# I actually want to have something like gnome-shell, but for niri.
dnf5 install -y --setopt=install_weak_deps=False \
	niri \
	squeekboard \
	foot \
	swaylock \
	swayidle \
	fuzzel \
	waybar

dnf5 install -y fish tmux neovim distrobox \
	NetworkManager-tui \
	pam-u2f pamu2fcfg pamtester \
	setroubleshoot \
	@virtualization \
	just \
	brightnessctl \
	flatpak

dnf5 remove -y firefox nano

if [ "deck" = "$VARIANT" ]; then
	dnf5 -y copr enable hhd-dev/hhd
	dnf5 -y install hhd adjustor hhd-ui
	dnf5 -y install \
		https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	dnf5 -y --setopt=install_weak_deps=False install \
        steam \
        lutris
fi
