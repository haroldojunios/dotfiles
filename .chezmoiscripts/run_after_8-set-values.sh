{{- if ne .osid "android" -}}
#!/bin/bash
{{- else -}}
#!/data/data/com.termux/files/usr/bin/bash
{{ end }}

{{ if ne .osid "android" }}
# fix accents not working on whatsapp on firefox
sudo set-val GTK_IM_MODULE xim /etc/environment
{{ end }}
