alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias t='tmux'

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"

export EDITOR="nvim"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

DISABLE_AUTO_TITLE=true

export PATH="$HOME/go/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"

# bun completions
[ -s "/Users/zacharycoulter/.bun/_bun" ] && source "/Users/zacharycoulter/.bun/_bun"
