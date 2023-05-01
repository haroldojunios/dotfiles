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

if ! [ -f /usr/share/alsa-card-profile/mixer/paths/analog-output-fixed.conf ] && [ -f /usr/share/alsa-card-profile/mixer/profile-sets/default.conf ]; then
  sudo bash -c "cat >/usr/share/alsa-card-profile/mixer/paths/analog-output-fixed.conf" <<EOF
[Element PCM]
switch = mute
volume = ignore
volume-limit = 0.01
override-map.1 = all
override-map.2 = all-left,all-right
EOF

  sudo cp /usr/share/alsa-card-profile/mixer/profile-sets/default.conf /usr/share/alsa-card-profile/mixer/profile-sets/profile-for-bad-soundcards.conf

  if command -v crudini &>/dev/null; then
    sudo crudini --set /usr/share/alsa-card-profile/mixer/profile-sets/profile-for-bad-soundcards.conf "Mapping analog-stereo" "paths-output" "analog-output-fixed"
  else
    LINE_NUMBER=$(grep -n -A8 "Mapping analog-stereo" /usr/share/alsa-card-profile/mixer/profile-sets/profile-for-bad-soundcards.conf |
      grep "paths-output = analog-output analog-output-lineout analog-output-speaker analog-output-headphones analog-output-headphones-2" |
      cut -d - -f 1)
    sudo sed -i "${LINE_NUMBER}s/.*/paths-output = analog-output-fixed/" /usr/share/alsa-card-profile/mixer/profile-sets/profile-for-bad-soundcards.conf
  fi
fi
