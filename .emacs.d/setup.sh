#!/bin/sh
EMACS_DIR=$HOME/dotfiles/.emacs.d/

# 各ディレクトリを作成する
dirs=('elisp' 'conf' 'public_repos')
for dir in ${dirs[@]}; do
    d=$EMACS_DIR$dir
    if [ ! -e $d ]; then
	mkdir -p $d
    fi
done
