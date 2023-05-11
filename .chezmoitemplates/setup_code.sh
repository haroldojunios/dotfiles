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
    visualstudioexptteam.intellicode-api-usage-examples
    visualstudioexptteam.vscodeintellicode
    yzhang.markdown-all-in-one
    zhuangtongfa.material-theme
  )

  EXT_LIST=$(code --list-extensions)

  for extension in "${extensions[@]}"; do
    if ! echo "$EXT_LIST" | grep -qi "$extension"; then
      code --install-extension "$extension"
    fi
  done
fi
