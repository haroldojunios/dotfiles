# shellcheck shell=bash
# docker
alias d='docker'
alias de='docker exec -it'
alias drmd='docker rm -fv'
alias drmi='docker rmi -f'
alias drmda='docker ps -aq | xargs docker rm -fv'
alias drmia='docker images -aq | xargs docker rmi -f'
