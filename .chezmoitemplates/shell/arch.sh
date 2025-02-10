# shellcheck shell=bash
# arch
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'

alias i='paru -S --noconfirm --needed'
alias r='paru -Rns --noconfirm'
alias u='sudo reflector --latest 50 --number 20 --sort score --protocol "http,https" --save /etc/pacman.d/mirrorlist && paru -Syu --noconfirm'
alias s='paru -Ss'
alias si='paru -Qi'
alias cl='yes | paru -Sc && pacman -Qtdq | xargs -r -n 1 sudo pacman -Rns --noconfirm && test -f ~/.cache/paru/clone && rm -rf ~/.cache/paru/clone || :'
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias fixkeys='sudo rm -rf /etc/pacman.d/gnupg && sudo pacman-key --init && sudo pacman-key --populate && sudo pacman -S --noconfirm archlinux-keyring'
alias rmpkg="sudo pacman -Rdd"
alias upd='/usr/bin/garuda-update'
alias bigpkg="expac -H M '%m\t%n' | sort -h | nl"                               # Sort installed packages according to size in MB
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'                              # List amount of -git packages
alias ripkg="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl" # Recent installed packages

# Get fastest mirrors
alias mirror='sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist'
alias mirrord='sudo reflector --latest 50 --number 20 --sort delay --protocol "http,https" --save /etc/pacman.d/mirrorlist'
alias mirrors='sudo reflector --latest 50 --number 20 --sort score --protocol "http,https" --save /etc/pacman.d/mirrorlist'
alias mirrora='sudo reflector --latest 50 --number 20 --sort age --protocol "http,https" --save /etc/pacman.d/mirrorlist'
