# Created by newuser for 5.9
#
#
#alias

alias ls='lsd'

alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias  v='nvim'
alias  hst='hyprctl hyprsunset temperature 2500'
alias hsg='hyprctl hyprsunset gamma 90'
#
#
eval "$(starship init zsh)"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export CAPACITOR_ANDROID_STUDIO_PATH="$HOME/.local/share/JetBrains/Toolbox/apps/android-studio/bin/studio.sh"
export CUDA_HOME="/opt/cuda"

# Load Angular CLI autocompletion.
command -v ng >/dev/null && source <(ng completion script)
export PATH="$HOME/.local/bin:$PATH"

# NPM global bin (added by Qwen Code installer)
export PATH="$HOME/.npm-global/bin:$PATH"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"
export KITTY_ENABLE_WAYLAND=1



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias unreal="$HOME/Downloads/UnrealEngine-5.8.0-release/Engine/Binaries/Linux/UnrealEditor"

# kimi-code
export PATH="$HOME/.kimi-code/bin:$PATH"
