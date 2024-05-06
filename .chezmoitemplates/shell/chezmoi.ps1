function cm { chezmoi @args }
function cma { chezmoi add @args }
function cmap { chezmoi apply @args }
function cmae { chezmoi add --encrypt @args }
function cmra { chezmoi re-add @args }
function cmc { cd $(chezmoi source-path) }
function cmu { chezmoi update --init --apply @args }
function cme { chezmoi edit @args }
function cmet { chezmoi execute-template @args }
