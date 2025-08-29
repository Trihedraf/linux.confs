#!/bin/bash
curl -fsSL "$(curl -s https://api.github.com/repos/yorukot/superfile/releases/latest \
| grep 'linux' \
| grep 'amd64' \
| grep -o 'https://[^"]*')" \
| sudo tar --transform='s/^.*/spf/g' -xzf - -C /usr/local/bin \
&& sudo chown 0:0 /usr/loca/bin/spf \
&& sudo chmod +x /usr/local/bin/spf
