# Zsh config

# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="agnoster"

# Plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# -----------------------------------------------------------------------------
# Omakub customizations
# -----------------------------------------------------------------------------

# Source Omakub files directly (aliases and shell work as-is)
source ~/.config/zsh/shell
source ~/.config/zsh/aliases
source ~/.config/zsh/completion
source ~/.config/zsh/functions
source ~/.config/zsh/init

# Zoxide init for zsh (instead of bash)
eval "$(zoxide init zsh)"

# FZF for zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh