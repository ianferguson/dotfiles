" vimrc cobbled together from several sources/random additions, with copypasta bits cited by url.
set nocompatible

call plug#begin()
Plug 'airblade/vim-gitgutter', { 'commit': '0e509fb' }
Plug 'bronson/vim-trailing-whitespace', { 'commit': '6b7cdec' }
Plug 'junegunn/fzf', { 'tag': '0.21.0-1', 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'ervandew/supertab', { 'commit': '40fe711' }
Plug 'jiangmiao/auto-pairs', { 'commit': '39f06b873a', 'for': 'go' }
Plug 'majutsushi/tagbar', { 'commit': '679a9d9' }
Plug 'tpope/vim-fugitive', { 'tag': 'v3.2' }
Plug 'tpope/vim-rhubarb', { 'commit': '5130596' }
Plug 'tpope/vim-endwise', { 'commit': 'bf90d8b' }
Plug 'tpope/vim-sensible', { 'commit': '2d9f34c' }
Plug 'mrmargolis/dogmatic.vim', { 'commit': 'fe10d5d' }
Plug 'dense-analysis/ale', { 'commit': 'bbe5153f' }
Plug 'tpope/vim-commentary', { 'commit': 'f8238d7' }
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'

Plug 'ianferguson/ftdefaults'

Plug 'dag/vim-fish', { 'for': 'fish', 'commit': '50b95cb' }

Plug 'fatih/vim-go', { 'for': 'go', 'tag': 'v1.22', 'do': ':GoInstallBinaries' }
Plug 'stamblerre/gocode', { 'for': 'go', 'commit': 'b039731', 'rtp': 'vim', 'do':'~/.vim/plugged/gocode/vim/symlink.sh' }

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
" autochdir is disabled to play nice with vim-go+gopls and go modules right
" now: https://github.com/fatih/vim-go/issues/2263
" set autochdir                   " Set working dir to directory of the file in the current buffer
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

" paste mode toggle
nnoremap <Leader>p :set invpaste paste?<CR>
set pastetoggle=<Leader>p
set showmode

" Unset paste on InsertLeave
augroup exitinsertexitpaste
  au!
  au InsertLeave * silent! set nopaste
augroup END

" Automatic rename of tmux window
augroup renametmuxwindow
  au!
  if exists('$TMUX') && !exists('$NORENAME')
    au BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
    au VimLeave * call system('tmux set-window automatic-rename on')
  endif
augroup END

" nudge vim to use system clipboard
set clipboard=unnamed

" dense-analysis/ale
let g:ale_open_list = 1           " Auto open loclist for ale issues
let g:ale_list_window_size = 4    " Set ale loclist size to 4

" hashivim/vim-terraform config
" we can't use `let g:terraform_fmt_on_save = 1` to just let the plugin handle
" everything because terraform fmt does not place nice with tfvars files:
" https://github.com/hashicorp/terraform/issues/19280
" and the plugin's default fmt on save saves not based on filetype, but
" non-configurably on file suffix:
" https://github.com/hashivim/vim-terraform/blob/bff65bf59401ef7d165637aedafe72f212ddf4c7/ftplugin/terraform.vim#L52-L58
" and the maintainer of the vim-terraform plugin indicated that that behavior
" was intended and not going to change:
" https://github.com/hashivim/vim-terraform/issues/129
" so instead, we've just ripped out the relevant bits here:
let g:terraform_fmt_on_save = 0
if get(g:, 'terraform_fmt_on_save', 0)
  augroup vim.terraform.fmt
    autocmd!
    autocmd BufWritePre *.tf call terraform#fmt()
  augroup END
endif

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
set statusline+=[#%n]                        " buffer number
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
set statusline +=\ %{fugitive#statusline()}
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

let g:seoul256_background = 233
colo seoul256
hi Normal cterm=NONE ctermbg=NONE

" aggressively highlight TKTK, since I never mean to commit those notes
highlight default tktkColor ctermbg=darkred guibg=darkred
augroup HiglightTODO
    autocmd!
    autocmd BufRead,BufNew,WinEnter,VimEnter * :silent! call matchadd('tktkColor', 'TKTK', -1)
augroup END

