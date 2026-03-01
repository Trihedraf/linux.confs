# Install Menu 

```bash
git clone https://github.com/Trihedraf/linux.confs && cd linux.confs && ./install.sh
```

# Arch System Setup Script

```bash
bash -c "$(curl -fsSL xurl.ing/arch)" -s --etc=ON --gui=ON
```

# Debian Trixie System Setup Script

```bash
sudo apt install curl && bash -c "$(curl -fsSL xurl.ing/debian)" -s --zfs=OFF
```

# Proxmox System Setup Script

For using proxmox as a debian server with zfs-on-root built-in.

```bash
apt install sudo
useradd -s /bin/bash $newUser
usermod -aG sudo $newUser
passwd $newUser
```

Login to new user.

```bash
bash -c "$(curl -fsSL xurl.ing/proxmox)"
```
