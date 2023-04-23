#!/bin/bash

# pc speaker
if command -v lsmod &>/dev/null; then
  if command -v rmmod &>/dev/null; then
    if lsmod | grep pcspkr &>/dev/null; then
      sudo rmmod pcspkr
    fi
    if lsmod | grep snd_pcsp &>/dev/null; then
      sudo rmmod snd_pcsp
    fi
  fi
fi

sudo bash -c "cat >/etc/modprobe.d/nobeep.conf" <<EOF
blacklist pcspkr
blacklist snd_pcsp
EOF

# memory
TOTAL_MEM=$(grep MemTotal /proc/meminfo | LC_ALL=C awk '{print $2/1024^2}')
if [ $(echo "$TOTAL_MEM>15" | bc) -eq 1 ]; then
  if ! grep -q "vm.vfs_cache_pressure=50" /etc/sysctl.conf; then
    sudo bash -c "cat >/etc/sysctl.conf" <<EOF
vm.vfs_cache_pressure=50
vm.swappiness=10
vm.dirty_background_ratio=1 #increase slowly, up to 10%, if CPU gets too busy with compression.
vm.dirty_ratio=20
EOF
  else
    sudo bash -c "cat >/etc/sysctl.conf" <<EOF
vm.vfs_cache_pressure=50
vm.swappiness=10
vm.dirty_background_ratio=10
vm.dirty_ratio=20
EOF
  fi
fi

{{ if or (eq .osid "linux-ubuntu") (eq .osidLike "linux-ubuntu") }}
if ! grep "zram-fraction" /etc/systemd/zram-generator.conf &>/dev/null; then
  sudo bash -c "cat >/etc/systemd/zram-generator.conf" <<EOF
[zram0]
zram-fraction = 1
EOF
fi
{{ else }}
if ! grep "zram-size" /etc/systemd/zram-generator.conf &>/dev/null; then
  sudo bash -c "cat >/etc/systemd/zram-generator.conf" <<EOF
[zram0]
zram-size = ram
compression-algorithm = zstd
host-memory-limit = none
EOF
fi
{{ end }}

# sddm
if ! grep Numlock /etc/sddm.conf | grep on &>/dev/null; then
  if command -v crudini &>/dev/null; then
    sudo crudini --set /etc/sddm.conf General Numlock on
  else
    sudo bash -c "cat >/etc/sddm.conf" <<EOF
[General]
Numlock=on
EOF
  fi
fi
