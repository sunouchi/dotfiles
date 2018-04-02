# make directory
mkdir $HOME/.vim/tmp
mkdir $HOME/.vim/tmp/backup
mkdir $HOME/.vim/tmp/swap
mkdir $HOME/.vim/tmp/undo
mkdir $HOME/.vim/tmp/info
mkdir $HOME/.vim/tmp/info/viminfo

# symbolic links
ln -s $HOME/dotfiles/.gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/.gitignore $HOME/.gitignore
#ln -s $HOME/dotfiles/.tmux $HOME/.tmux
ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/dotfiles/.vim $HOME/.vim
ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
