# -- History --
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# -- Shell options --
setopt AUTO_CD
setopt EXTENDED_GLOB
unsetopt BEEP

# -- Environment --
export XDG_CONFIG_HOME="$HOME/.config"
export PYTHONDONTWRITEBYTECODE=1
export EDITOR=nvim
export VISUAL=nvim
export LANG=en_US.UTF-8

# -- Key bindings (Emacs mode) --
bindkey -e

# -- Completion --
autoload -Uz compinit && compinit

# -- Prompt (git-aware, keeps the feel of the old terminalparty theme) --
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats '[%F{yellow}%b%f]'
setopt PROMPT_SUBST
PROMPT='%m : %2~ ${vcs_info_msg_0_}%(?.%F{green}.%F{red})>%f '

# -- Sub-configs --
source $HOME/dotfiles/.zshrc.alias
source $HOME/dotfiles/.zshrc.custom
