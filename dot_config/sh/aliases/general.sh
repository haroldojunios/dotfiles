alias ytd='youtube-dl -o "%(title)s.%(ext)s" -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"'
alias matlab='~/Programs/MATLAB/R2018a/bin/matlab'
alias gitignore_fix='git rm -r --cached . ; git add .'
alias list_ports='python3 -m serial.tools.list_ports'
alias minicom='minicom -con'
alias gksu='pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY'
alias gsettings_list='gsettings list-recursively | grep -e'
# alias clean_desktop_icons='for i in ~/.local/share/applications/*.desktop; do which $(grep -Poh "(?<=Exec=).*?( |$)" $i) > /dev/null || rm -i $i; done'
alias font_cache='fc-cache -f -v'
#alias update_joplin='wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash'
#alias joplin='$HOME/.joplin/Joplin.AppImage'
alias search_text='sudo grep -i -a -B1000 -A1000'
alias setclip='xclip -selection c'
alias getclip='xclip -selection c -o'
# alias lc='ls --color'
# alias ls='ls --color=auto -A'
# alias la='ls -a'
alias cp='cp -r'
# alias mirror_list='reflector -c "Brazil" -p http,https --sort age | sudo tee /etc/pacman.d/mirrorlist'
#alias mirror_list='reflector -p http,https --sort age | sudo tee /etc/pacman.d/mirrorlist'
alias datenow='date "+%y%m%d%H%M%S"'
alias now='date "+%s"'
alias cformat='clang-format -fallback-style="{BasedOnStyle: Google, AlignAfterOpenBracket: DontAlign,SpacesBeforeTrailingComments: 1,BreakBeforeBraces: Allman,BreakStringLiterals: true,ColumnLimit: 80, MaxEmptyLinesToKeep: 1,ContinuationIndentWidth: 2,AlwaysBreakBeforeMultilineStrings: false,AlignEscapedNewlines: Left,AlignConsecutiveMacros: AcrossComments,AllowAllParametersOfDeclarationOnNextLine: false,AllowShortLambdasOnASingleLine: true,BinPackArguments: true,BinPackParameters: true,BreakConstructorInitializers: AfterColon,IncludeBlocks: Regroup,AllowShortFunctionsOnASingleLine: None}" -i **/*.{c,h}'
alias fix_exec='chmod -R -x .;chmod -R +X .'
alias sfix_exec='sudo chmod -R -x .;sudo chmod -R +X .'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
#alias pf='peerflix --not-on-top --mpv --path ~/Downloads/torrent-stream  $(xclip -selection clipboard -o)'
# alias at='aria2c -d ~/Downloads/torrent $(xclip -selection clipboard -o)'
# alias ar='aria2c --enable-rpc --rpc-listen-all'
alias ar='aria2c'
alias arpc='aria2rpc'
# alias argt='aria2c --bt-metadata-only=true --bt-save-metadata=true --dir=$HOME/Downloads/aria2'
# alias arst='aria2c --show-files'
# alias arsf='aria2c --select-file=INDEX TORRENT'
alias rc=rsync_celular
alias rs='rsync --archive --human-readable --partial --progress --fuzzy --inplace --prune-empty-dirs --hard-links --info=progress2,name --no-inc-recursive --no-whole-file'
alias rsl='rsync --archive --human-readable --whole-file --no-compress --hard-links --fuzzy --inplace --info=progress2,name --no-inc-recursive'
alias rsd='rs --delete-after'
alias rsh='bash -c "(cd; rsync -amyvhPl --inplace --relative --info=progress2,name \
  --no-inc-recursive --info=progress2,name \
  .config .local/share .ssh Backup Books calibre \
  Desktop Documents Downloads Music Pictures Videos \
  /run/media/haroldo/2d16e6d3-9832-4262-9eca-8bd79ce45c60/home)"'
# alias rsm='rs --remove-source-files' #find /dir -type d -empty -delete
alias c='TMUX= code'
alias c.='TMUX= code .'
alias tkill='tmux list-sessions | grep -v attached | cut -d: -f1 |  xargs -t -n1 tmux kill-session -t'
alias gzip='gzip -kv'
alias 7zc='7z a -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on -aoa'
alias 7zc2='7z a -t7z -m0=lzma2 -mx=9 -mfb=64 -md=32m -ms=on -aoa'
alias 7zx='7z a -t7z -mx=9 -mfb=273 -ms -md=31 -myx=9 -mtm=- -mmt -mmtf -md=1536m -mmf=bt3 -mmc=10000 -mpb=0 -mlc=0 -aoa'
alias tlmgr='$TEXMFDIST/scripts/texlive/tlmgr.pl' # --usermode'
alias freecad="LD_PRELOAD=/usr/lib64/libstdc++.so.6 LIBGL_ALWAYS_SOFTWARE=1 $HOME/Programs/FreeCAD/FreeCAD.AppImage"

alias nano="nano --rcfile ~/.config/nanorc/nanorc"

## Useful aliases
# Replace ls with exa
alias ls='exa -a --color=always --group-directories-first --icons'  # preferred listing
alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons'  # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.="exa -a | egrep '^\.'"                                     # show only dotfiles
alias ip="ip -color"

# Replace some more things with better alternatives
alias cat='bat --style full'

# Common use
alias grubup="sudo update-grub"
alias tarnow='tar -acf '
alias untar='tar -xvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='grep -F --color=auto'
alias egrep='grep -E --color=auto'
alias hw='hwinfo --short' # Hardware Info

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"
