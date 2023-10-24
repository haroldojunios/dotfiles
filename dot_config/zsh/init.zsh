if [ -f ~/.config/sh/tmuz.sh ]; then
  source ~/.config/sh/tmuz.sh
fi

if [ -f ~/.functions ]; then
  source ~/.functions
fi

if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

if [ -f ~/.zsh_aliases ]; then
  source ~/.zsh_aliases
fi

ZSH="${HOME}/.zsh"
ZSH_CACHE_DIR="$ZSH/cache"
ZSH_COMPLETION_DIR="$ZSH_CACHE_DIR/completions"

if [ ! -d "$ZSH_COMPLETION_DIR" ]; then
  mkdir -p "$ZSH_COMPLETION_DIR"
fi

HISTFILE="$ZSH/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE

export ZDOTDIR="$ZSH"
ZSH_COMPDUMP="$ZDOTDIR/.zcompdump"

autoload -Uz compinit
if [ "$(find $ZSH_COMPDUMP -mmin +1440)" ]; then # 1440 min = 24 h
  compinit
else
  compinit -C
fi

if [ -f ~/.config/sh/colors.sh ]; then
  source ~/.config/sh/colors.sh
fi
