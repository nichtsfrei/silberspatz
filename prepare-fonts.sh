#!/bin/sh
VERSION="v3.4.0"
FONT_DIR="./system_files/usr/local/share/fonts"
FONT="AdwaitaMono"
mkdir -p $FONT_DIR || true
[ ! -f "$FONT.zip" ] && curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/$VERSION/$FONT.zip
unzip -d $FONT_DIR/$FONT $FONT.zip
