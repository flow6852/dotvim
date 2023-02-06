if(has('nvim'))
    augroup termloop
        autocmd!
        autocmd ExitPre * call TermLoop()
        autocmd TermOpen * startinsert | call s:bufnew()
    augroup End

    tnoremap <silent><expr> <CR>
        \ (len(split(getline(getcurpos()[1]))) > 1 && split(getline(getcurpos()[1]))[1] == "cd") ?
        \ '<Cmd>call ChDir()<CR><CR><CR>' :
        \ '<CR>'

    function! s:bufnew(...)
        if &buftype == "terminal" && &filetype == ""
            set filetype=terminal
        endif
    endfunction

    function! ChDir(...) " for my env
        let cwd = split(getline(getcurpos()[1] - 1))[1] " $USER@$HOST $CWD $GITSTATUS
        let cmds = split(getline(getcurpos()[1]))
        if len(cmds) > 2 && cmds[1] == "cd" " example) > cd test -> cd ${PWD}/test
            let nextdir = substitute(cwd . "/" . cmds[2], "/[^\/]*/\\.\\.", "", "g")
            let absdir = substitute(cmds[2], "/[^\/]*/\\.\\.", "", "g")
            if (cmds[2][1] == '/' || cmds[2][1] == '~') && isdirectory(expand(absdir)) " /tmp/....
                echom "chdir " . expand(absdir)
                execute "chdir " . expand(absdir)
            elseif isdirectory(expand(nextdir))
                echom "chdir " . expand(nextdir)
                execute "chdir " . expand(nextdir)
            endif
        elseif len(cmds) == 2 && cmds[1] == "cd" " example)  cd
            echom expand(environ()['HOME'])
            execute "chdir " . expand(environ()['HOME'])
        endif
    endfunction

    function! TermLoop(...)
        if len(getwininfo()) == 1 && getwininfo()[0]['terminal'] == 0 && len(split(execute("buffers"), "\n")) > 1
            let s:listed_buffer = getbufinfo({'buflisted': 1})[0]['bufnr']
            execute getbufinfo({'buflisted': 1})[0]['bufnr'] . 'buffer'
            vsplit
        endif
    endfunction
endif
