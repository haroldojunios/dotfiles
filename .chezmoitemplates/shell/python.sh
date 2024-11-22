# shellcheck shell=bash
# python
alias p='python3'
# alias pf='isort .; black .'
alias pye='source $(poetry env info --path)/bin/activate.fish || \
  source ./venv/Scripts/activate &>/dev/null || \
  source ./venv/bin/activate.fish &>/dev/null || \
  source ./venv/bin/activate &>/dev/null'
alias pyv='python3 -m venv venv'
alias pipf='pip freeze > requirements.txt'
alias pipr='pip install -r requirements.txt'
alias pyserver="python3 -m http.server"
alias runserver='python3 manage.py runserver 0.0.0.0:8080'
alias poi='poetry lock; poetry install --sync'
alias poa='poetry add'
alias por='poetry run'
alias pop='poetry run python'
alias rf='ruff check --fix; ruff format'
# alias ca='conda activate'
# alias cab='conda activate base'
# alias cam='conda activate main'
# alias cda='conda deactivate'
[ -f /opt/miniconda3/bin/conda ] && alias conda='/opt/miniconda3/bin/conda'
