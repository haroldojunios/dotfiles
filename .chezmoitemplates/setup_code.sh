CODE=
if command -v code >/dev/null; then
  CODE=code
elif command -v code-server >/dev/null; then
  CODE=code-server
fi

if [ -n "$CODE" ]; then
  extensions=(
    bmalehorn.vscode-fish
    bpruitt-goddard.mermaid-markdown-syntax-highlighting
    bungcip.better-toml
    christian-kohler.path-intellisense
    donjayamanne.githistory
    eamodio.gitlens
    editorconfig.editorconfig
    esbenp.prettier-vscode
    gruntfuggly.todo-tree
    james-yu.latex-workshop
    jock.svg
    mechatroner.rainbow-csv
    mhutchie.git-graph
    mkhl.shfmt
    mrmlnc.vscode-duplicate
    ms-azuretools.vscode-docker
    ms-python.black-formatter
    ms-python.python
    ms-toolsai.jupyter
    ms-vscode.atom-keybindings
    ms-vscode.cmake-tools
    mushan.vscode-paste-image
    pkief.material-icon-theme
    richie5um2.vscode-sort-json
    ritwickdey.liveserver
    shd101wyy.markdown-preview-enhanced
    streetsidesoftware.code-spell-checker
    streetsidesoftware.code-spell-checker-portuguese-brazilian
    tabnine.tabnine-vscode
    yzhang.markdown-all-in-one
    zhuangtongfa.material-theme
  )

  if [ "$CODE" = "code" ]; then
    extensions=(
      ${extensions[@]}
      visualstudioexptteam.intellicode-api-usage-examples
      visualstudioexptteam.vscodeintellicode
    )
  fi

  EXT_LIST=$($CODE --list-extensions)

  for extension in "${extensions[@]}"; do
    if ! echo "$EXT_LIST" | grep -qi "$extension"; then
      $CODE --install-extension "$extension"
    fi
  done
fi

{{ if .isWSL }}
if [ -f /mnt/c/Users/RZ9/AppData/Roaming/Code/User/settings.json ]; then
  if ! cmp -s {{ .chezmoi.sourceDir }}/symlinks/code/settings.json /mnt/c/Users/RZ9/AppData/Roaming/Code/User/settings.json; then
    read -n1 -p "Code settings differ. Choose: (overwrite Target, overwrite Source, Ignore) " ans
    echo
    case "$ans" in
    t | T)
      cp {{ .chezmoi.sourceDir }}/symlinks/code/settings.json /mnt/c/Users/RZ9/AppData/Roaming/Code/User/
      ;;
    s | S)
      cp /mnt/c/Users/RZ9/AppData/Roaming/Code/User/settings.json {{ .chezmoi.sourceDir }}/symlinks/code/
      ;;
    esac
  fi
else
  mkdir -p /mnt/c/Users/RZ9/AppData/Roaming/Code/User/
  cp {{ .chezmoi.sourceDir }}/symlinks/code/settings.json /mnt/c/Users/RZ9/AppData/Roaming/Code/User/
fi
{{ end }}
