setl tabstop=2
setl shiftwidth=2
autocmd BufWritePost *.tex exec s:build()

function! s:compile_command_setting() abort
    let l:compile_command = "latexmk --lualatex " .  expand("%")
    return l:compile_command
endfunction

function! s:zathura_view_setting() abort
    if has('nvim')
        let l:zvs = "-x \"nvr --servername @servername +%{line} %{input}\" --synctex-forward @line:@col:@tex @pdf"
    else
        let l:zvs = "-x \"vim --servername vimd --remote +%{line} %{input}\" --synctex-forward @line:@col:@tex @pdf"
    endif
    return l:zvs
endfunction


function! s:build() abort
    " let l:cmd = "zathura"
    " let l:cmd .= ' ' . s:zathura_view_setting()

    " let l:cmd = substitute(l:cmd, '@servername', v:servername, 'g')
    " let l:cmd = substitute(l:cmd, '@line', line('.'), 'g')
    " let l:cmd = substitute(l:cmd, '@col', line('.'), 'g')
    " let l:cmd = substitute(l:cmd, '@tex', expand("%"), 'g')
    " let l:cmd = substitute(l:cmd, '@pdf', expand("%:r") . ".pdf", 'g')

    call system(s:compile_command_setting())
    " let l:status = v:shell_error
    " echo s:zathura_view_setting()
    " echo l:status
    " if l:status == 0
    "     echom system(l:cmd)
    " endif
endfunction
