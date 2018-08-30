alias ls='ls --color=auto -F'
alias la='ls --color=auto -laF'
alias ll='ls --color=auto -llF'
alias df='df -h'
alias gb='git branch'
alias gs='git status'
alias ga='git add -A .'
alias cdd='cd $HOME/Desktop'
alias be='bundle exec'
alias today='date "+%Y-%m-%d"'
alias updatedb='sudo /usr/libexec/locate.updatedb'
#alias ctags="`brew --prefix`/bin/ctags"
#alias vim='TERM=xterm-256color nvim'

# pythonで.pycファイルを生成させない
export PYTHONDONTWRITEBYTECODE=1

# pyenv
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"

# tmux
alias tmux="TERM=screen-256color-bce tmux"

# direnv
#eval "$(direnv hook zsh)"
#export EDITOR=vim

# Display user and hostname in prompt
PS1="[\u@\h \w\$]\$ "
