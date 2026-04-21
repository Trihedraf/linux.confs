#!/bin/bash

# 1. Download and install Syncthing to $HOME/.local/bin
VERSION=$(curl -s https://api.github.com/repos/syncthing/syncthing/releases/latest | jq -r .tag_name) # Update to latest version as needed
declare -l OS; OS=$(uname)
ARCH=$(uname -m)
if [ "$ARCH" == "x86_64" ]; then
    ARCH="amd64"
elif [ "$ARCH" == "aarch64" ]; then
    ARCH="arm64"
fi
https://github.com/syncthing/syncthing/releases/download/v2.0.15/syncthing-linux-amd64-v2.0.15.tar.gz
echo "Downloading Syncthing $VERSION for $OS $ARCH..."
curl -L -o /tmp/syncthing.tar.gz "https://github.com/syncthing/syncthing/releases/download/$VERSION/syncthing-$OS-$ARCH-$VERSION.tar.gz" || exit

mkdir -p "$HOME/.local/bin" || exit
tar -xzf /tmp/syncthing.tar.gz --strip-components=1 -C "$HOME/.local/bin" "syncthing-$OS-$ARCH-$VERSION/syncthing" || exit
chmod +x "$HOME/.local/bin/syncthing" || exit

rm /tmp/syncthing.tar.gz || exit
echo "Syncthing installed to $HOME/.local/bin/syncthing"

# 2. Initialize configuration (creates $HOME/.config/syncthing/config.xml)
"$HOME/.local/bin/syncthing" generate || exit

# 3. Create systemd user service file
mkdir -p "$HOME/.config/systemd/user/" || exit
cat > "$HOME/.config/systemd/user/syncthing.service" <<EOF
[Unit]
Description=Syncthing - Open Source Continuous File Synchronization
Documentation=man:syncthing(1)
After=network.target

[Service]
Type=simple
ExecStart=/home/$(whoami)/.local/bin/syncthing serve --no-browser --no-restart
Restart=on-failure
RestartSec=5
SuccessExitStatus=3 4
RestartForceExitStatus=3 4

[Install]
WantedBy=default.target
EOF

# 4. Enable and start the service
systemctl --user daemon-reload || exit
systemctl --user enable --now syncthing.service || exit

# 5. Enable remote access
sleep 5
"$HOME/.local/bin/syncthing" cli config gui raw-address set 0.0.0.0:8384 || exit

echo "Syncthing service enabled and started."
echo "Access GUI at http://localhost:8384"
