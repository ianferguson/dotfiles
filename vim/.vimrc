set nocompatible
call pathogen#incubate()
call pathogen#helptags()
execute pathogen#infect()

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

set number

filetype indent on
filetype on
filetype plugin on
syntax on

autocmd vimenter * NERDTree

" vim has supported fish shell since v7.4-256
" if &shell =~# 'fish$'
"        set shell=sh
" endif
