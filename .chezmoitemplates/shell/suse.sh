# shellcheck shell=bash
# suse aliases
alias i='sudo zypper install --no-confirm --no-recommends --auto-agree-with-licenses'
alias ir='sudo zypper install --no-confirm --auto-agree-with-licenses'
alias u='sudo zypper update --no-confirm --no-recommends --auto-agree-with-licenses'
alias uc='u --allow-vendor-change'
alias r='sudo zypper remove --no-confirm --clean-deps'
alias s='zypper --no-refresh search'
alias si='zypper --no-refresh search --installed-only'
alias sp='zypper --no-refresh search --provides'
alias ar='sudo zypper addrepo'
