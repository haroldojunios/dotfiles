bindkey -e

#bindkey '^I' autosuggest-accept

case $TERM in
screen-256color)
  bindkey '\e[1~' beginning-of-line
  bindkey '\e[4~' end-of-line
  bindkey '\e[3~' delete-char
  bindkey '^H' backward-kill-word
  bindkey '^[[3;5~' kill-word
  bindkey '^[[1;5D' backward-word
  bindkey '^[[1;5C' forward-word
  ;;
*) ;;

esac

bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
bindkey '\^U' backward-kill-line

x-copy-region-as-kill() {
  zle copy-region-as-kill
  print -rn $CUTBUFFER | xclip -selection clipboard -i
}
zle -N x-copy-region-as-kill
x-kill-region() {
  zle kill-region
  print -rn $CUTBUFFER | xclip -selection clipboard -i
}
zle -N x-kill-region
x-yank() {
  CUTBUFFER=$(xclip -selection clipboard -o </dev/null)
  zle yank
}
zle -N x-yank
# bindkey -e '\ew' x-copy-region-as-kill
# bindkey -e '^W' x-kill-region
# bindkey -e '^Y' x-yank
bindkey -e '\e[2~' x-yank
