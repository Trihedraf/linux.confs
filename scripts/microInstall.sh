#!/bin/bash

micro_url=$(curl -s https://api.github.com/repos/zyedidia/micro/releases/latest | jq -r ".assets[] | select(.name | test(\"linux64-static.tar.gz\")) | .browser_download_url" | grep -v sha)
curl -fsSL "$micro_url" | tar -xvzf - -C "$HOME/.local/bin" --strip-components 1 --no-anchored micro
