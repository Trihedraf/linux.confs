# Install Menu 
```bash
git clone https://github.com/Trihedraf/linux.confs && cd linux.confs && ./install.sh
```

# Arch System Setup Script
```bash
curl -fsSL https://raw.githubusercontent.com/Trihedraf/linux.confs/refs/heads/master/arch.sh | sh
```

# Debian Trixie System Setup Script
```bash
sudo apt install curl && curl -fsSL https://raw.githubusercontent.com/Trihedraf/linux.confs/refs/heads/master/debian.sh | sh -s -- --docker=ON --tailscale=ON --zfs=ON
```
