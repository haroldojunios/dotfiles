# ubuntu aliases
alias i='sudo apt install -y'
alias r='sudo apt remove -y'
alias u='sudo apt update && sudo apt upgrade -y'
alias s='apt search'
alias cl='dpkg --list | grep "^rc" | cut -d " " -f 3 | xargs sudo dpkg --purge 2>/dev/null; sudo apt autoclean -y && sudo apt autoremove -y'
