source <(fzf --zsh)
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export HOMEBREW_NO_INSTALL_CLEANUP=TRUE

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="$HOME/.local/bin:$PATH"

# bun completions
[ -s "/Users/zachary.coulter/.bun/_bun" ] && source "/Users/zachary.coulter/.bun/_bun"
