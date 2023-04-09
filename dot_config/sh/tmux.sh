if [ "$TERM_PROGRAM" != "vscode" ]; then
  if command -v tmux &>/dev/null && [ -n "$PS1" ] && [ -z "$TMUX" ]; then
    # if [ -n "$VSCODE" ]; then
    #   SESSION="vscode $(pwd | tr -d '.' | rev | cut -d '/' -f1 | rev)"
    #   tmux attach-session -d -t "$SESSION" || tmux new-session -s "$SESSION"
    # el
    if [ -n "$SSH_CONNECTION" ]; then
      if [ tmux has-session -t "ssh" ] 2>/dev/null; then
        exec tmux attach-session -d -t "ssh"
      else
        exec tmux new-session -s "ssh"
      fi
    else
      exec tmux
    fi
  fi
fi
