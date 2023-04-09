SPACESHIP_PROMPT_ORDER=(
  # time      # Time stampts section
  user # Username section
  dir  # Current directory section
  # host      # Hostname section
  git # Git section (git_branch + git_status)
  # hg        # Mercurial section (hg_branch  + hg_status)
  package # Package version
  node    # Node.js section
  # ruby      # Ruby section
  python # Python section
  # elm       # Elm section
  # elixir    # Elixir section
  # xcode     # Xcode section
  # swift     # Swift section
  # golang    # Go section
  # php       # PHP section
  # rust      # Rust section
  # haskell   # Haskell Stack section
  # java      # Java section
  # julia     # Julia section
  # docker    # Docker section
  # aws       # Amazon Web Services section
  # gcloud    # Google Cloud Platform section
  venv  # virtualenv section
  conda # conda virtualenv section
  # dotnet    # .NET section
  # kubectl   # Kubectl context section
  # terraform # Terraform workspace section
  # ibmcloud  # IBM Cloud section
  # exec_time # Execution time
  # async     # Async jobs indicator
  line_sep # Line break
  # battery   # Battery level and status
  # jobs      # Background jobs indicator
  # exit_code # Exit code section
  char # Prompt character
)

SPACESHIP_RPROMPT_ORDER=(
  rprompt_prefix
  jobs
  exec_time
  exit_code
  time
  rprompt_suffix
)

spaceship_rprompt_prefix() {
  echo -n '%{'$'\e[1A''%}'
}
spaceship_rprompt_suffix() {
  echo -n '%{'$'\e[1B''%}'
}

SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_DEFAULT_PREFIX="/ "
SPACESHIP_CHAR_SYMBOL_ROOT="#"
SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_PREFIX=
SPACESHIP_DIR_TRUNC=2
SPACESHIP_DIR_TRUNC_PREFIX="…/"
SPACESHIP_EXEC_TIME_ELAPSED=5
# SPACESHIP_BATTERY_SHOW=always
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_EXIT_CODE_SYMBOL="✘ "
