#!/bin/sh

id -u podman &>/dev/null || { echo "Error: User podman does not exist."; exit 1; }

getent group podman &>/dev/null || { echo "Error: Group podman does not exist."; exit 1; }

grep -q "$(id -u podman):65536" /etc/subuid || echo "$(id -u podman):65536" >> /etc/subuid
grep -q "$(id -g podman):65536" /etc/subgid || echo "$(id -g podman):65536" >> /etc/subgid 
loginctl enable-linger podman

echo "subuid:"
cat /etc/subuid
echo "subgid:"
cat /etc/subgid
