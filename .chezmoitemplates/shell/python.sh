# shellcheck shell=bash
# python
alias p='python3'
# alias pf='isort .; black .'
alias pye='source ./venv/Scripts/activate &>/dev/null || \
source ./venv/bin/activate.fish &>/dev/null || \
source ./venv/bin/activate &>/dev/null'
alias pyv='python3 -m venv venv'
alias pipf='pip freeze > requirements.txt'
alias pipr='pip install -r requirements.txt'
alias pyserver="python3 -m http.server"
alias runserver='python3 manage.py runserver 0.0.0.0:8080'
alias ca='conda activate'
alias cab='conda activate base'
alias cam='conda activate main'
alias cda='conda deactivate'
alias ea='source env/bin/activate'
alias va='source .venv/bin/activate'
