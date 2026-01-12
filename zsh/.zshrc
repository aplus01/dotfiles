# Zsh config

# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="agnoster"

# Plugins
plugins=(git zsh-autosuggestions)

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

# -----------------------------------------------------------------------------
# Prompt customizations (must come after oh-my-zsh)
# -----------------------------------------------------------------------------

# Track command execution time
preexec() {
  cmd_start=$EPOCHREALTIME
}

precmd() {
  if [[ -n $cmd_start ]]; then
    local elapsed=$(( EPOCHREALTIME - cmd_start ))
    if (( elapsed >= 1 )); then
      # Format based on duration
      if (( elapsed >= 60 )); then
        cmd_time=$(printf "%dm%ds" $((elapsed/60)) $((elapsed%60)))
      else
        cmd_time=$(printf "%.1fs" $elapsed)
      fi
    else
      cmd_time=""  # Don't show for quick commands
    fi
    unset cmd_start
  fi
}

prompt_context() {
  if [[ -n $SSH_CONNECTION ]]; then
    prompt_segment black default "%m"
  fi
}


prompt_dir() {
    prompt_segment 39d $CURRENT_FG '%1~'
}

EMOJIS=(🔥 💥 👹 💋 💃 🍑 🌵 🐍 🐢 💩 👻 🎳 🍐 🍊 🍋 🍌 🍉 🍇 🍈 🍍 🍆 🐔 🐧 🚀 😎 🍣 🍺 👾 🙈 🙉 🙊 💀)
SEL_EMOJI=${EMOJIS[RANDOM % ${#EMOJIS[@]} - 1]}
PROMPT='$SEL_EMOJI %{%f%b%k%}$(build_prompt) '
RPROMPT='${cmd_time:+⏱ $cmd_time}'
