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
sed -i \
  -e 's|https://enterprise.proxmox.com/debian/ceph-squid|http://download.proxmox.com/debian/ceph-squid|g' \
  -e 's/Components: enterprise/Components: no-subscription/g' \
  /etc/apt/sources.list.d/ceph.sources

sed -i \
  -e 's|https://enterprise.proxmox.com/debian/pve|http://download.proxmox.com/debian/pve|g' \
  -e 's/Components: pve-enterprise/Components: pve-no-subscription/g' \
  /etc/apt/sources.list.d/pve-enterprise.sources && \
  mv /etc/apt/sources.list.d/pve-enterprise.sources /etc/apt/sources.list.d/pve.sources

newUser=YourUsername
apt install sudo
useradd -m -s /bin/bash $newUser
usermod -aG sudo $newUser
passwd $newUser
```

Login to new user.

```bash
bash -c "$(curl -fsSL xurl.ing/proxmox)"
```
