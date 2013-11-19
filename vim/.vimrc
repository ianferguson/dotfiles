set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
filetype indent on
filetype on
filetype plugin on
syntax on
if &shell =~# 'fish$'
        set shell=sh
endif
execute pathogen#infect()
