#!/bin/bash

CRONTAB="
@reboot fish -c 'fisher update >/dev/null'
{{ if eq .osid "android" -}}
0 * * * * find $HOME/storage/shared/Android/media/com.whatsapp/WhatsApp/Databases/ -type f ! -name msgstore.db.crypt14 -delete >/dev/null 2>&1
{{ end -}}
"

if command -v crontab &>/dev/null; then
  if ! crontab -l 2>/dev/null | grep -q "$CRONTAB"; then
    echo $CRONTAB | crontab -
  fi
fi
