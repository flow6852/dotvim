call ddu#custom#patch_local('vim_variable', cfg)
nmap <silent> ;h <Cmd> call ddu#start({'name': 'vim_variable', 'sources': [
    \ {'name': 'vim_variable', 'params': {'bufnr': bufnr('%')}},
    \ {'name': 'vim_option', 'params': {'bufnr': bufnr('%')}},
    \ {'name': 'vim_function', 'params': {'bufnr': bufnr('%')}},
    \ {'name': 'vim_command', 'params': {'bufnr': bufnr('%')}},
    \ {'name': 'vim_event', 'params': {'bufnr': bufnr('%')}}]})<CR>

cmap <silent> <C-h> <Cmd>call DduKindVim_typeSetcmdline()<CR>

function DduKindVim_typeSetcmdline()
    let getcmdline = getcmdline()
    let getcmdpos = getcmdpos()
    call feedkeys("\<Esc>", 't')
    call ddu#start({'name': 'vim_variable', 'sources': [
        \ {'name': 'vim_variable', 'params': {'bufnr': bufnr('%')}},
        \ {'name': 'vim_option', 'params': {'bufnr': bufnr('%')}},
        \ {'name': 'vim_function', 'params': {'bufnr': bufnr('%')}},
        \ {'name': 'vim_command', 'params': {'bufnr': bufnr('%')}},
        \ {'name': 'vim_event', 'params': {'bufnr': bufnr('%')}}],
        \ 'actionParams': {'getcmdline': getcmdline, 'getcmdpos': getcmdpos}})
endfunction
call ddu#custom#patch_local('help', extend(cfg, {'sources': [{'name': 'help'}]}))


" cmap <silent> <C-h> <Cmd> call ddu#start({'name': 'vim_variable', 'sources': [
"     \ {'name': 'vim_variable', 'params': {'bufnr': bufnr('%')}},
"     \ {'name': 'vim_option', 'params': {'bufnr': bufnr('%')}},
"     \ {'name': 'vim_function', 'params': {'bufnr': bufnr('%')}},
"     \ {'name': 'vim_command', 'params': {'bufnr': bufnr('%')}},
"     \ {'name': 'vim_event', 'params': {'bufnr': bufnr('%')}}]})<CR>
