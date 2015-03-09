" vimrc cobbled together from several sources/random additions, with copypasta
" bits cited by url.
set nocompatible
call pathogen#incubate()
call pathogen#helptags()
execute pathogen#infect()

set tabstop=2
set cmdheight=2
set shiftwidth=2
set expandtab
set autoindent
set number

filetype indent on
filetype on
filetype plugin on
syntax on

" disable vim-json's double quote hiding #TooMuchMagic
let g:vim_json_syntax_conceal = 0

" use git ls-files to drive ctrlp
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

" default to just file name matching, not path for ctrp
let g:ctrlp_by_filename = 1

" ignore angular directives/attributes when linting
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

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
let g:syntastic_go_checkers = ["go", "gotype", "gofmt", "govet", "golint" ]

"" vim-go settings/mappings
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go nmap <Leader>e <Plug>(go-rename)

au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>s <Plug>(go-implements)

" fail gofmt silently in vim-go, since syntastic should be highlighting already for us
let g:go_fmt_fail_silently = 0
let g:go_fmt_command = "goimports"

"" SQL setup
" push things to default to using pg sql formatting
let g:sql_type_default = 'pgsql'

" dbext profiles
" let g:dbext_default_type = 'PGSQL'
let g:dbext_default_profile_pg = 'type=PGSQL:user=postgres'
