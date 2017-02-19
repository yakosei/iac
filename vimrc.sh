#!/bin/bash
var_prefix_org=$(date +'-%Y%m%d-%H%M%S.org')
var_vimrc=~/.vimrc
[ -f $var_vimrc ] || touch $var_vimrc
\cp -p $var_vimrc $var_vimrc${var_prefix_org:?}
cat <<'__EOD__' >$var_vimrc
""""""""""""""""""""""""""""""""
""  user defined
""""""""""""""""""""""""""""""""
" Generate by iac
"## common ##
syntax on
set showcmd
"set nu
set ruler
"set list
set cursorline
set showmatch
set wrap
set display=lastline
set whichwrap=h,l
set scrolloff=5
"set visualbell
set visualbell t_vb=
set noerrorbells

"## tab ##
set expandtab
set shiftwidth=2
"set autoindent
set tabstop=2

"## search ##
set hlsearch
set wrapscan
"set ignorecase
"set smartcase
set incsearch

"## intellisense ##
set pumheight=10
set wildmode=list
"set wildmode=list:longest
set completeopt=menuone
for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-",'\zs')
  exec "imap " . k . " " . k . "<C-N><C-P>"
endfor
imap <expr> <TAB> pumvisible() ? "\<Down>" : "\<Tab>"

"EOF
__EOD__
[ "$(diff $var_vimrc $var_vimrc$var_prefix_org)" ] || \mv -f $var_vimrc$var_prefix_org $var_vimrc
