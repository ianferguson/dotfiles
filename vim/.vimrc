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

if &shell =~# 'fish$'
        set shell=sh
endif
