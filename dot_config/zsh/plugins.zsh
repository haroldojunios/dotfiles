# # >>> needed for fastfile >>>
# default() {
#   (($ + parameters[$1])) && return 0
#   typeset -g "$1"="$2" && return 3
# }

# fastfile_dir="$HOME/.config/fastfile"
# fastfile_var_prefix="@"
# # <<< needed for fastfile <<<

WD_CONFIG="$HOME/.config/warprc"

if [ ! -f "${HOME}/.zgenom/zgenom.zsh" ]; then
  git clone --depth 1 https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
fi

source "${HOME}/.zgenom/zgenom.zsh"

zgenom autoupdate

# if the init script doesn't exist
if ! zgenom saved; then
  zgenom load marlonrichert/zsh-autocomplete
  zgenom load zsh-users/zsh-autosuggestions
  zgenom load zsh-users/zsh-completion
  zgenom load spaceship-prompt/spaceship-prompt
  zgenom load zsh-users/zsh-syntax-highlighting

  zgenom ohmyzsh plugins/git-extras
  zgenom ohmyzsh plugins/github
  zgenom ohmyzsh plugins/colored-man-pages
  zgenom ohmyzsh plugins/command-not-found
  zgenom ohmyzsh plugins/fasd
  zgenom ohmyzsh plugins/extract
  zgenom ohmyzsh plugins/jsontools
  zgenom ohmyzsh plugins/universalarchive
  zgenom ohmyzsh plugins/wd
  zgenom ohmyzsh plugins/z

  zgenom save

  zgenom compile "$HOME/.zshrc"
  [ -d "$HOME/.zsh" ] && zgenom compile "$HOME/.zsh"
  [ -n "$ZDOTDIR" ] && zgenom compile "$ZDOTDIR"
fi

if [ ! -f "$ZSH_COMPLETIONS_DIR/_gh" ] && command -v gh &>/dev/null; then
  gh completion -s zsh >"$ZSH_COMPLETIONS_DIR/_gh"
fi
