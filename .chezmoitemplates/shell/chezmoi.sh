# shellcheck shell=bash
# chezmoi aliases
alias cm=chezmoi
alias cma='chezmoi add'
alias cmae='chezmoi add --encrypt'
alias cmra='chezmoi re-add'
alias cmc='cd $(chezmoi source-path)'
alias cmu='chezmoi update --init --apply'
alias cme='chezmoi edit'
alias cmet='chezmoi execute-template'
