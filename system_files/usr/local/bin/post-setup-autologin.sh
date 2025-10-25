#!/bin/sh

CONTENT="
[Service]
ExecStart=
ExecStart=-/sbin/agetty --noreset --noclear --autologin $(whoami) - \${TERM}
"
printf "$CONTENT" | sudo tee /etc/systemd/system/getty@tty1.service.d/override.conf 
