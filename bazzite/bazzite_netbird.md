# From host
distrobox create netbird --init --image debian:trixie -a "--cap-add=NET_ADMIN" --additional-packages systemd --root && distrobox enter --root netbird

# From inside the container
distrobox-export -b /usr/bin/netbird

# From host
netbird up --management-url https://netbird.webfsh.com --allow-server-ssh --enable-ssh-root --enable-rosenpass --rosenpass-permissive
