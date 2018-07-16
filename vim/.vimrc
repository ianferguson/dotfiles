" vimrc cobbled together from several sources/random additions, with copypasta bits cited by url.
set nocompatible

call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'bronson/vim-trailing-whitespace'
Plug 'cespare/vim-toml'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dag/vim-fish'
Plug 'elzr/vim-json'
Plug 'ervandew/supertab'
Plug 'exu/pgsql.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'
Plug 'fatih/vim-go', { 'for': 'go', 'tag': 'v1.17' , 'do': ':GoInstallBinaries'  }
Plug 'mdempsky/gocode', { 'for': 'go', 'rtp': 'vim', 'do':'~/.vim/plugged/gocode/vim/symlink.sh'  }
" Plug 'zchee/deoplete-go', { 'for': 'go', 'do': 'make' }
Plug 'mrmargolis/dogmatic.vim'
Plug 'rbenv/rbenv-default-gems', { 'for': 'ruby' }
Plug 'rbenv/ruby-build', { 'for': 'ruby' }
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'tpope/vim-rbenv', { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-sensible'
Plug 'vim-scripts/dbext.vim'
Plug 'vim-syntastic/syntastic'
Plug '~/.vim/bundle/ftdefaults'
call plug#end()

set tabstop=2
set cmdheight=2
set shiftwidth=2
set expandtab
set autoindent
set number
set list

filetype indent on
filetype on
filetype plugin on
syntax on

" disable vim-json's double quote hiding #TooMuchMagic
let g:vim_json_syntax_conceal = 0

" use git ls-files to drive ctrlp
let g:ctrlp_user_command = ['.git', 'cd %s; git ls-files']

" default to just file name matching, not path for ctrp
let g:ctrlp_by_filename = 1

" include current buffer's file in the matching list
let g:ctrlp_match_current_file = 1

" ignore angular directives/attributes when linting
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

" set supertab to choose mode contextually, i.e., magically use the right
" gocode suggestions when I hit tab after a go token
" if this stops working for go at some point in the future, or breaks
" something else: just add let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
" to the ftdefaults for go files
let g:SuperTabDefaultCompletionType = "context"

" vim has supported fish shell since v7.4-256, and sensible already does this
" for us anyways
" if &shell =~# 'fish$'
"        set shell=sh
" endif

"" statusline settings
" somewhat taken from http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
" another good resource: http://learnvimscriptthehardway.stevelosh.com/chapters/17.html
" TODO use () to group item groups and set min.max widths better

" left side:
set statusline=                               " clear statusline
set statusline+=%y                            " filetype
set statusline+=\                             " padding from filetype to name
" set statusline+=%f                          " full filename, if desired
set statusline+=%m                            " modified flag
set statusline+=%t                            " tail of the filename

" middle break
set statusline+=%=                            " left/right alignment separator

" right side:
set statusline+=%#warningmsg#                 " name following highlight group
set statusline+=%{SyntasticStatuslineFlag()}  " include syntastic status flag/highlighting
set statusline+=%*                            " pop back to standard highlighting
set statusline+=[%02n]                        " buffer number
set statusline+=[                             " open buffer pos/size bracket
set statusline+=%c,                           " cursor column
set statusline+=%l                            " cursor line
set statusline+=]                             " close buffer pos/size bracket
" set statusline+=/%L                          " total lines
" set statusline+=\ %P                         " percent through file
set statusline+=\                             " padding from right

" status colors:
" bold statuslines, do not invert them (which is the default)
hi StatusLine term=bold cterm=bold ctermbg=235 ctermfg=cyan
hi clear StatusLineNC
hi StatusLineNC ctermfg=245 ctermbg=235
" clear sign column formatting so it matches up with the line number column
hi clear SignColumn
"" end of status line settings

"" syntastic settings:
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_java_javac_autoload_maven_classpath = 0 " dont autoload the entire maven classpath

" run FixWhitespace plugin prior to writing the buffer -- will trim trailing
" whitespace off of files
autocmd BufWritePre * :FixWhitespace

" create command to pretty print json
com! Jsonpp %!python -m json.tool

" turn on search highlighting
set hlsearch

"This unsets the "last search pattern" register by hitting return
nnoremap <silent> <return> :noh<return><return>

