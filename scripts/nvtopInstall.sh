#!/usr/bin/env bash

nvtop_url=$(curl -s https://api.github.com/repos/Syllo/nvtop/releases/latest | jq -r ".assets[] | select(.name | test(\"AppImage\")) | .browser_download_url" | grep -v sha)
curl -fsSL "$nvtop_url" -o "$HOME/.local/bin/nvtop"
chmod +x "$HOME/.local/bin/nvtop"
