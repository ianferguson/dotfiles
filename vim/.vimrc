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

" disable vim-json's double quote hiding #TooMuchMagic
let g:vim_json_syntax_conceal = 0

" use git ls-files to drive ctrlp
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

" default to just file name matching, not path for ctrp
let g:ctrlp_by_filename = 1

" ignore angular directives/attributes when linting
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

" vim has supported fish shell since v7.4-256
" if &shell =~# 'fish$'
"        set shell=sh
" endif

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" vim-go settings/mappings
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

let g:go_fmt_command = "goimports"

