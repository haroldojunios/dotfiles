function _nvm_use_on_pwd_change --on-variable PWD
    nvm use --silent 2>/dev/null
end

_nvm_use_on_pwd_change
