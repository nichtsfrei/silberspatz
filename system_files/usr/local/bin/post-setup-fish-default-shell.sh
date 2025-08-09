#!/bin/sh
set -ex
sudo usermod --shell /usr/bin/fish $(whoami)
