# shellcheck shell=bash
# termux
alias i='apt install -y'
alias r='apt remove -y'
alias u='apt update && apt upgrade -y'
alias s='apt search'
alias cl='dpkg --list | grep "^rc" | cut -d " " -f 3 | xargs dpkg --purge && apt autoclean -y && apt autoremove -y'

# termux api
alias tp='termux-camera-photo storage/pictures/$(date "+%Y%m%d_%H%M%S").jpg'
alias code-server='NODE_OPTIONS="--require ${HOME}/.config/android-as-linux.js" code-server'
