# dotfiles

sunouchi の個人用 dotfiles。

## セットアップ

```bash
git clone git@github.com:sunouchi/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
brew bundle install
```

## 主な内容

- zsh — `.zshrc`, `.zshrc.custom`, `.zshrc.alias`, `.zprofile`
- vim / nvim — `.vimrc`, `.vimrc.*`
- tmux — `.tmux.conf`
- git — `.gitconfig`, `.gitignore`
- Homebrew — `Brewfile`

言語ランタイム（node / python / ruby 等）は [mise](https://mise.jdx.dev/) で管理。
