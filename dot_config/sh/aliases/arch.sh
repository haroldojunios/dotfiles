[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'

alias i='paru -S --noconfirm --needed'
alias r='paru -Rns --noconfirm'
alias u='paru -Syu --noconfirm'
alias s='paru -Ss'
alias si='paru -Qi'
alias cl='sudo pacman -Rns (pacman -Qtdq)'

alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias rmpkg="sudo pacman -Rdd"
alias upd='/usr/bin/garuda-update'
alias big="expac -H M '%m\t%n' | sort -h | nl"                                # Sort installed packages according to size in MB
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'                            # List amount of -git packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl" # Recent installed packages

# Get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
