" vimrc cobbled together from several sources/random additions, with copypasta bits cited by url.
set nocompatible

call plug#begin()
Plug 'airblade/vim-gitgutter', { 'commit': '7be1f830925' }
Plug 'bronson/vim-trailing-whitespace', { 'commit': '4c59654' }
Plug 'junegunn/fzf', {  'commit': '80b5bc1', 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'ervandew/supertab', { 'commit': '40fe711' }
Plug 'jiangmiao/auto-pairs', { 'commit': '39f06b873a' }
Plug 'majutsushi/tagbar', { 'commit': '387bbad' }
Plug 'tpope/vim-fugitive', { 'tag': 'v3.0' }
Plug 'tpope/vim-rhubarb', { 'commit': '75ad917' }
Plug 'tpope/vim-endwise', { 'commit': 'f67d022169bd' }
Plug 'tpope/vim-sensible', { 'commit': '5dc6eb2d80' }
Plug 'mrmargolis/dogmatic.vim', { 'commit': 'fe10d5d' }
Plug 'dense-analysis/ale', { 'commit': '6e18c03' }
Plug 'tpope/vim-commentary', { 'commit': '141d9d32a9f' }
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'

Plug 'ianferguson/ftdefaults'

Plug 'dag/vim-fish', { 'for': 'fish', 'commit': '50b95cb' }

Plug 'fatih/vim-go', { 'for': 'go', 'tag': 'v1.20', 'do': ':GoInstallBinaries' }
Plug 'mdempsky/gocode', { 'for': 'go', 'commit': '466551c', 'rtp': 'vim', 'do':'~/.vim/plugged/gocode/vim/symlink.sh' }

Plug 'elzr/vim-json', { 'for': 'json', 'commit': '3727f08' }

Plug 'rbenv/rbenv-default-gems', { 'for': 'ruby' }
Plug 'rbenv/ruby-build', { 'for': 'ruby' }
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'tpope/vim-rbenv', { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

Plug 'vim-scripts/dbext.vim', { 'for': 'sql' }
Plug 'exu/pgsql.vim', { 'for': 'sql' }

Plug 'cespare/vim-toml', { 'for': 'toml' }

Plug 'hashivim/vim-hashicorp-tools', { 'for': ['hcl','tf','terraform'] }

Plug 'junegunn/seoul256.vim'

call plug#end()

set autoindent
set autoread                    " Automatically reread changed files without asking me anything
set backspace=indent,eol,start  " Makes backspace key more powerful.
set cmdheight=2
set expandtab
set hlsearch                 " turn on search highlighting
set ignorecase               " Search case insensitive...
set list
set nobackup                 " Don't create annoying backup files
set noswapfile               " Don't use swapfile
set number
set pumheight=10             " Completion window max size
set shiftwidth=2
set showcmd                  " Show me what I'm typing
set smartcase                " ... but not it begins with upper case
set tabstop=2

filetype indent on
filetype on
filetype plugin on
syntax on

augroup vimrc
  au!
  " Unset paste on InsertLeave
  au InsertLeave * silent! set nopaste

  " Automatic rename of tmux window
  if exists('$TMUX') && !exists('$NORENAME')
    au BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
    au VimLeave * call system('tmux set-window automatic-rename on')
  endif
augroup END

" nudge vim to use system clipboard
set clipboard=unnamed

" dense-analysis/ale auto pop open loclist with issue
let g:ale_open_list = 1

" hashivim/vim-terraform config
let g:terraform_fmt_on_save = 1

"disable vim-json's double quote hiding #TooMuchMagic
let g:vim_json_syntax_conceal = 0

" junegunn/fzf
nnoremap <c-p> :FZF<cr>
let g:fzf_layout = { 'down': '~20%'  }


" set supertab to choose mode contextually, i.e., magically use the right
" gocode suggestions when I hit tab after a go token
" if this stops working for go at some point in the future, or breaks
" something else: just add let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
" to the ftdefaults for go files
let g:SuperTabDefaultCompletionType = "context"

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
set statusline+=%*                            " pop back to standard highlighting
set statusline+=[%02n]                        " buffer number
set statusline+=[                             " open buffer pos/size bracket
set statusline+=%c,                           " cursor column
set statusline+=%l                            " cursor line
set statusline+=]                             " close buffer pos/size bracket
set statusline+=\                             " padding from right

" status colors:
" bold statuslines, do not invert them (which is the default)
hi StatusLine term=bold cterm=bold ctermbg=235 ctermfg=cyan
hi clear StatusLineNC
hi StatusLineNC ctermfg=245 ctermbg=235
" clear sign column formatting so it matches up with the line number column
hi clear SignColumn
"" end of status line settings

" run FixWhitespace plugin prior to writing the buffer -- will trim trailing
" whitespace off of files
augroup cleanwhitespace
    autocmd!
    autocmd BufWritePre * :FixWhitespace
augroup END

" quickfix window settings:
augroup quickfix
    autocmd!
    " place quick fix buffer to the bottom
    " This is problematic, as it doesn't play nice with location lists
    " sometimes, but until vim-go supports using `botright copen` instead of
    " `copen`, it seems like the least worst approach to ensuring that
    " quickfix windows don't get pinned under the tagbar windows:
    " https://github.com/fatih/vim-go/issues/108
    autocmd FileType qf wincmd J
    " force quick fix to line wrap
    autocmd FileType qf setlocal wrap
augroup END

"This unsets the "last search pattern" register by hitting return
nnoremap <silent> <return> :noh<return><return>

" paste mode toggle
nnoremap <Leader>p :set invpaste paste?<CR>
set pastetoggle=<Leader>p
set showmode

let g:seoul256_background = 233
colo seoul256
hi Normal cterm=NONE ctermbg=NONE

