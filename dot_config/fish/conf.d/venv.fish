function __auto_source_venv --on-variable PWD --description "Activate/Deactivate virtualenv on directory change"
    status --is-command-substitution; and return

    # Check if we are inside a git repository
    if git rev-parse --show-toplevel &>/dev/null
        set dir (realpath (git rev-parse --show-toplevel))
    else
        set dir (pwd)
    end

    if not test -f "$dir/pyproject.toml" || not set venv_dir (poetry env info --path 2>/dev/null)
        # Find a virtual environment in the directory
        set VENV_DIR_NAMES env .env venv .venv
        for venv_dir in $dir/$VENV_DIR_NAMES
            if test -e "$venv_dir/bin/activate.fish"
                break
            end
        end
    end

    # Activate venv if it was found and not activated before
    if test "$VIRTUAL_ENV" != "$venv_dir" -a -e "$venv_dir/bin/activate.fish"
        source $venv_dir/bin/activate.fish
        # Deactivate venv if it is activated but the directory doesn't exist
    else if not test -z "$VIRTUAL_ENV" -o -e "$venv_dir"
        type -q deactivate && deactivate
    end
end

__auto_source_venv
