function _nvm_use_on_pwd_change --on-variable PWD
    if type -q nvm
        nvm use --silent 2>/dev/null
    end
end

_nvm_use_on_pwd_change
