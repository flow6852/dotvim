set guifont=Source\ Code\ Pro\ Medium:h17
colorscheme slate

augroup termloop
    autocmd!
    autocmd ExitPre * call TermLoop()
    autocmd BufWritePost * call TermLoop()
augroup End

function! TermLoop(...)
    if len(getwininfo()) == 1 && getwininfo()[0]['terminal'] == 0
        vsplit
        let s:listed_buffer = getbufinfo({'buflisted': 1})[0]['bufnr']
        execute getbufinfo({'buflisted': 1})[0]['bufnr'] . 'buffer'
    endif
endfunction

