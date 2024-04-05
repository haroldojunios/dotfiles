function git_auto_fetch --on-variable PWD \
    --description "git fetch automatically wherever inside a git repository"
    if git rev-parse --is-inside-work-tree &>/dev/null
        git fetch origin 2>/dev/null || :
    end
end
