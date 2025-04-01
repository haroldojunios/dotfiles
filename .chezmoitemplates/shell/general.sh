# shellcheck shell=bash
# ls
alias ls='eza -a --color=always --group-directories-first --icons'                       # preferred listing
alias l='ls'                                                                             # alternative
alias la='eza -a --color=always --group-directories-first --icons'                       # all files and dirs
alias ll='eza -a -l --total-size --color=always --group-directories-first --icons'       # long format
alias lg='eza -a -l --git --total-size --color=always --group-directories-first --icons' # long format w/ gitignore
alias lt='eza -aT -I .git --color=always --group-directories-first --icons'              # tree listing
alias l.="eza -a | egrep '^\.'"                                                          # show only dotfiles

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# cat
alias cat='bat --style full'
alias ct='cat'

# compression
alias 7zc='7z a -t7z -m0=lzma2 -mx=9 -mfb=64 -md=32m -ms=on -aoa'
alias 7zx='7z a -t7z -mx=9 -mfb=273 -ms -md=31 -myx=9 -mtm=- -mmt -mmtf -md=1536m -mmf=bt3 -mmc=10000 -mpb=0 -mlc=0 -aoa'
alias gz='gzip -kv'
alias t='tar -acf '
alias ut='tar -xvf '

# find
alias red='find . -type d -empty -delete'
alias li='fd -e tex -e bib -x latexindent -wd -m -g /dev/null {} >/dev/null'

# ffmpeg
alias ff='ffmpeg -hide_banner -y'
alias ffp='ffprobe -v quiet -print_format json -show_format -show_streams'

# general
alias ytd='youtube-dl -o "%(title)s.%(ext)s" -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"'
alias matlab='~/Programs/MATLAB/R2018a/bin/matlab'
alias gitignore_fix='git rm -r --cached . ; git add .'
alias list_ports='python3 -m serial.tools.list_ports'
alias minicom='minicom -con'
alias gksu='pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY'
alias gsettings_list='gsettings list-recursively | grep -e'
alias fc='fc-cache -f -v'
alias search_text='sudo grep -i -a -B1000 -A1000'
alias setclip='xclip -selection c'
alias getclip='xclip -selection c -o'
alias cp='cp -r'
alias datenow='date "+%Y%m%d%H%M%S"'
alias now='date "+%s"'
alias cformat='clang-format -fallback-style="{BasedOnStyle: Google, AlignAfterOpenBracket: DontAlign,SpacesBeforeTrailingComments: 1,BreakBeforeBraces: Allman,BreakStringLiterals: true,ColumnLimit: 80, MaxEmptyLinesToKeep: 1,ContinuationIndentWidth: 2,AlwaysBreakBeforeMultilineStrings: false,AlignEscapedNewlines: Left,AlignConsecutiveMacros: AcrossComments,AllowAllParametersOfDeclarationOnNextLine: false,AllowShortLambdasOnASingleLine: true,BinPackArguments: true,BinPackParameters: true,BreakConstructorInitializers: AfterColon,IncludeBlocks: Regroup,AllowShortFunctionsOnASingleLine: None}" -i **/*.{c,h}'
alias fix_exec='chmod -R -x .; chmod -R +X .'
alias sfix_exec='sudo chmod -R -x .; sudo chmod -R +X .'
alias pf='peerflix --not-on-top --mpv --path ~/.cache/torrent-stream'
alias pfc='pf $(xclip -o -selection clipboard)'
alias ar='aria2c'
alias arpc='aria2rpc'
alias at='aria2c -d ~/Downloads/torrent'
alias rc=rsync_celular
alias rs='rsync --archive --human-readable --partial --progress --fuzzy --inplace --prune-empty-dirs --hard-links --info=progress2,name --no-inc-recursive --no-whole-file'
alias rsl='rsync --archive --human-readable --whole-file --no-compress --hard-links --fuzzy --inplace --info=progress2,name --no-inc-recursive'
alias rsd='rs --delete-after'
alias rsh='bash -c "(cd; rsync -amyvhPl --inplace --relative --info=progress2,name \
  --no-inc-recursive --exclude={venv,virtualenv,Cache,CachedData} \
  .ssh Backup Books calibre \
  Desktop Documents Downloads Music Pictures Videos \
  /media/data/home)"'
# alias rsm='rs --remove-source-files' #find /dir -type d -empty -delete
alias c='TMUX= code'
alias c.='TMUX= code .'
alias tkill='tmux list-sessions | grep -v attached | cut -d: -f1 | xargs -r -t -n1 tmux kill-session -t'
alias nano="nano --rcfile ~/.config/nanorc/nanorc"
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='grep -F --color=auto'
alias egrep='grep -E --color=auto'
command -v hw >/dev/null && alias hw='hwinfo --short'
command -v ip >/dev/null && alias ip="ip -color"
alias jc="journalctl -rxb"
alias ug="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias wget='wget -c '
alias pm='ps auxf | sort -nr -k 4'
alias pm10='ps auxf | sort -nr -k 4 | head -10'
command -v firefox >/dev/null && alias fp='firefox -P personal &>/dev/null & disown'
command -v vivaldi >/dev/null && alias vp='vivaldi --profile-directory=personal &>/dev/null & disown'
alias sudo='sudo --preserve-env=PATH'
command -v nvim >/dev/null && alias n='nvim'
alias nnn='nnn -aeP p'
alias esp-idf='source /opt/esp-idf/export.fish'
alias tm='tmux at &>/dev/null || tmux'
alias t='task sync >/dev/null; task'
alias tt="taskwarrior-tui"
