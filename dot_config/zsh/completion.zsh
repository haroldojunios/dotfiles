# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"          # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true # automatically find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# zstyle ':autocomplete:*' insert-unambiguous yes
# zstyle ':autocomplete:list-choices:*' min-input 3
# zstyle ':autocomplete:*' list-lines 5
zstyle ':autocomplete:*' max-lines 25%
# zstyle ':completion:*' list-prompt   ''
# zstyle ':completion:*' select-prompt ''
