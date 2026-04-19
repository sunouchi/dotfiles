# make directory
#mkdir ~/.vim/tmp
#mkdir ~/.vim/tmp/backup
#mkdir ~/.vim/tmp/swap
#mkdir ~/.vim/tmp/undo
#mkdir ~/.vim/tmp/info
#mkdir ~/.vim/tmp/info/viminfo

# symbolic links
ln -s ~/dotfiles/.gitconfig ~/
ln -s ~/dotfiles/.gitignore ~/
#ln -s ~/dotfiles/.tmux ~/
ln -s ~/dotfiles/.tmux.conf ~/
#ln -s ~/dotfiles/.vim ~/
ln -s ~/dotfiles/.vimrc ~/
ln -s ~/dotfiles/.zshrc ~/
ln -s ~/dotfiles/.zprofile ~/
ln -s ~/dotfiles/.bashrc ~/

# XDG config
mkdir -p ~/.config
ln -s ~/dotfiles/.config/nvim ~/.config/nvim
mkdir -p ~/.config/mise
ln -s ~/dotfiles/.config/mise/config.toml ~/.config/mise/config.toml
