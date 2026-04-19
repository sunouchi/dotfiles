source $HOME/dotfiles/.zshrc.theme
source $HOME/dotfiles/.zshrc.alias
source $HOME/dotfiles/.zshrc.custom

export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$(brew --prefix node)/bin:$PATH"
unsetopt BEEP
