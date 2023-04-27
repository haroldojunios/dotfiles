#!/bin/bash

if command -v micro &>/dev/null; then
  for plugin in aspell misspell fzf wc autofmt jump detectindent filemanager; do
    if ! [ -d "$HOME/.config/micro/plug/$plugin" ]; then
      if micro -plugin install $plugin | grep -q "out-of-date"; then
        micro -plugin update $plugin &>/dev/null
      fi
    fi
  done
fi
