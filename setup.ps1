Set-ExecutionPolicy RemoteSigned
iwr -useb get.scoop.sh | iex

scoop install main/chezmoi

chezmoi init --apply haroldojunios
