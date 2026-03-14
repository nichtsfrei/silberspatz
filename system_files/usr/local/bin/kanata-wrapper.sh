#!/bin/sh

CONFIG_FILE="$HOME/.config/kanata/default.kbd"
if [ ! -f "$CONFIG_FILE" ]; then
    CONFIG_FILE="/etc/kanata/default.kbd"
fi
echo "Using $CONFIG_FILE"
exec /usr/local/bin/kanata --cfg "$CONFIG_FILE"
