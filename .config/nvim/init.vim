" -------------------------------------------------------------------------------
"  Base

" ENV
let $CACHE = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let $DATA = empty($XDG_DATA_HOME) ? expand('$HOME/.local/share') : $XDG_DATA_HOME

" Load rc file
function! s:load(file) abort
    let s:path = expand('$CONFIG/nvim/rc/' . a:file . '.vim')

    if filereadable(s:path)
        execute 'source' fnameescape(s:path)
    endif
endfunction

call s:load('plugins')



" -------------------------------------------------------------------------------
"  
" 行数、改行
set number
set noswapfile

" インデント設定
filetype indent on
set tabstop=2
set shiftwidth=2
set expandtab


" -------------------------------------------------------------------------------
"  dein.vim

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/sunouchi/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/sunouchi/.cache/dein')
  call dein#begin('/Users/sunouchi/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/sunouchi/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/deol.nvim', { 'rev': 'a1b5108fd' })

  " プラグインリストを収めたTOMLファイル
  " あらかじめTOMLファイルを用意しておく
  let g:rc_dir    = expand("~/.config/nvim/")
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
