# shellcheck shell=bash
# chezmoi
alias cm=chezmoi
alias cmad='chezmoi add'
alias cmap='chezmoi apply'
alias cmae='chezmoi add --encrypt'
alias cmra='chezmoi re-add'
alias cmc='cd $(chezmoi source-path)'
alias cmu='{{ if ne .chezmoi.os "android" }}sudo -v && {{ end }}chezmoi update --init --apply'
alias cme='chezmoi edit'
alias cmet='chezmoi execute-template'
