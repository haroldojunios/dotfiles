function p { python @args }
function pf { isort .; black . }
function pye { & ./venv/Scripts/activate.ps1 }
function pyv { python -m venv venv }
function pipf { pip freeze > requirements.txt }
function pipr { pip install -r requirements.txt }
function pyserver { python3 -m http.server }
function runserver { python3 manage.py runserver 0.0.0.0:8080 }
function ea { source env/bin/activate }
function va { source .venv/bin/activate }
