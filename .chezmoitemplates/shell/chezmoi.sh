# shellcheck shell=bash
# chezmoi
alias cm='chezmoi --keep-going'
alias cma='chezmoi --keep-going --refresh-externals=never add'
alias cmae='chezmoi --keep-going --refresh-externals=never add --encrypt'
alias cmap='chezmoi --keep-going apply'
alias cmra='chezmoi --keep-going --refresh-externals=never re-add'
alias cmc='cd $(chezmoi source-path)'
alias cmu='{{ if ne .chezmoi.os "android" }}sudo -v && {{ end }}chezmoi update --init --apply'
alias cme='chezmoi --keep-going --refresh-externals=never edit'
alias cmea='chezmoi --keep-going --refresh-externals=never edit --apply'
alias cmet='chezmoi --keep-going --refresh-externals=never execute-template'
