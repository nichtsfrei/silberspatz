#!/bin/sh
set -ex
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub io.gitlab.librewolf-community
flatpak install -y flathub com.github.tchx84.Flatseal
flatpak install -y flathub org.videolan.VLC
flatpak install -y flathub org.keepassxc.KeePassXC

