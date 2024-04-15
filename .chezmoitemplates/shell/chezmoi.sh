# shellcheck shell=bash
# chezmoi
alias cm=chezmoi
alias cma='chezmoi --refresh-externals=never add'
alias cmae='chezmoi --refresh-externals=never add --encrypt'
alias cmap='chezmoi apply'
alias cmra='chezmoi --refresh-externals=never re-add'
alias cmc='cd $(chezmoi source-path)'
alias cmu='{{ if ne .chezmoi.os "android" }}sudo -v && {{ end }}chezmoi update --init --apply'
alias cme='chezmoi --refresh-externals=never edit'
alias cmea='chezmoi --refresh-externals=never edit --apply'
alias cmet='chezmoi --refresh-externals=never execute-template'
