TagbarOpen
highlight OverLength ctermfg=red guibg=#592929
match OverLength /\%121v.\+/

"" my main vimrc has set list on it, which is great
"" for the majority of things that do not use tabs for indentation
"" but not at all great in golang where tabs are the standard
set nolist

"" vim-go settings/mappings
aug vimgo-mapping
  au!
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
aug END

" fail gofmt silently in vim-go, since syntastic should be highlighting already for us
let g:go_fmt_fail_silently = 0
let g:go_fmt_command = "goimports"
