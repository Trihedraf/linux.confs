#!/usr/bin/env bash

ARCH=$(uname -m)
if [ "$ARCH" == "x86_64" ]; then
    ARCH="amd64"
elif [ "$ARCH" == "aarch64" ]; then
    ARCH="arm64"
fi

gdu_url=$(curl -s https://api.github.com/repos/dundee/gdu/releases/latest | jq -r ".assets[] | select(.name | test(\"linux_${ARCH}.tgz\")) | .browser_download_url")
curl -fsSL "$gdu_url" | tar -xzOf - > "$HOME/.local/bin/gdu" && chmod +x "$HOME/.local/bin/gdu"
