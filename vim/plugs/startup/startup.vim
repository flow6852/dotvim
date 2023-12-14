" hook_source {{{

" https://ryochack.hatenablog.com/entry/2018/04/08/162354
" for vim-plug
" check the specified plugin is installed
function Global_is_plugged(name)
    if match(&runtimepath, a:name) >= 0
        return 1
    else
        return 0
    endif
endfunction

let g:ui = 'pum'

augroup localfile 
     autocmd! 
     autocmd BufRead,BufNewFile *.md setfiletype markdown 
     autocmd BufRead,BufNewFile *.tex setfiletype tex 
     autocmd BufRead,BufNewFile *.c setfiletype c 
     autocmd BufRead,BufNewFile *.scala setfiletype scala 
     autocmd BufRead,BufNewFile *.v setfiletype coq 
     autocmd BufRead,BufNewFile *.sml setfiletype sml 
     autocmd BufRead,BufNewFile *.snip setfiletype neosnippet 
     autocmd BufRead,BufNewFile *.bib setfiletype bibtex 
     autocmd BufRead,BufNewFile *.vim setfiletype vim 
     autocmd BufRead,BufNewFile *.cob setfiletype cobol 
augroup End

autocmd WinLeave * if (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | cclose | endif

 " }}}
