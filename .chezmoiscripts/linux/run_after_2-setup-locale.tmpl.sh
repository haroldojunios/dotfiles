{{- if ne .osid "android" -}}
#!/bin/bash
{{- else -}}
#!/data/data/com.termux/files/usr/bin/bash
{{ end }}

set -eu

{{ if ne .osid "android" }}
sudo "${HOME}/.local/bin/set-val" LC_ALL pt_BR.UTF-8 /etc/default/locale
sudo "${HOME}/.local/bin/set-val" LANG en_US.UTF-8 /etc/default/locale
sudo "${HOME}/.local/bin/set-val" LC_MEASUREMENT C /etc/default/locale
sudo "${HOME}/.local/bin/set-val" LC_MONETARY C /etc/default/locale
sudo "${HOME}/.local/bin/set-val" LC_NUMERIC C /etc/default/locale
sudo "${HOME}/.local/bin/set-val" LC_TIME pt_BR.UTF-8 /etc/default/locale
sudo "${HOME}/.local/bin/set-val" LANGUAGE en_US:pt_BR /etc/default/locale

if ! localedef --list-archive | grep -q "en_US.utf8" || ! localedef --list-archive | grep -q "pt_BR.utf8"; then
  sudo sed -e '/en_US.UTF-8/s/^#*//g' -i /etc/locale.gen
  sudo sed -e '/pt_BR.UTF-8/s/^#*//g' -i /etc/locale.gen

  sudo locale-gen &>/dev/null
fi
{{ end }}
