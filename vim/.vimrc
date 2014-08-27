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

" open NERDTree by default, switch cursor back to
" the non-nerd tree pane, and close when nerdtree is the only
" buffer left open
autocmd vimenter * NERDTree
autocmd VimEnter * wincmd w
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" taken from http://stackoverflow.com/a/5403847
" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

" disable vim-json's double quote hiding #TooMuchMagic
let g:vim_json_syntax_conceal = 0

" vim has supported fish shell since v7.4-256
" if &shell =~# 'fish$'
"        set shell=sh
" endif
