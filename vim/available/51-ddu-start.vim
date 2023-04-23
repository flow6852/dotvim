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

nmap <silent> ;b <Cmd>call ddu#start({'name': 'filer', 'sources': [{'name': 'buffer', 'params' : {'expandSymbolicLink': v:true}}]})<CR>
nmap <silent> ;f <Cmd>call ddu#start({'name': 'filer', 'sources': [{'name': 'file_rec', 'params' : {'expandSymbolicLink': v:true}}]})<CR>
nmap <silent> ;g <Cmd>call ddu#start({'name': 'grep',
                                    \ 'sources':[{'name': 'rg', 
                                    \             'params': {'input': expand('<cword>'),
                                    \                        'path':expand('.'),
                                    \                        'highlights': 'Search',
                                    \                        'args': ['--column', '--no-heading', '--json', '--follow']
                                    \ }}]})<CR>
nmap <silent> ;q <Cmd>call ddu#start({
    \   'name': 'qf',
    \   'sources': [{
    \       'name': 'qf',
    \       'params': {'what': {'title': 'Diagnostics'}, 'format': format}
    \               },
    \       {'name': 'qf',
    \        'params': {'what': {'title': 'VimTeX'}, 'format': format,
    \                   'isSubst': v:true,
    \                  }
    \       }]})<CR>
nmap <silent> ;v <Cmd> call ddu#start({
            \ 'name': 'qf', 'sources': [
            \ {'name': 'qf', 
            \ 'params': {'what': {'title': ':vimgrep'},
            \            'isSubst': v:true,
            \            'format': format,
            \            'dup': v:true}},
            \ {'name': 'qf', 
            \ 'params': {'what': {'title': ':lvimgrep'},
            \            'isSubst': v:true,
            \            'format': format,
            \            'nr': 0,
            \            'dup': v:true}}]})<CR>
nmap <silent> ;u <Cmd> call ddu#start({'name': 'url', 'sources': [{'name': 'url', 'params':{'ignoredDirectories': '.git'}}]})<CR>
nmap <silent> ;a <Cmd> call ddu#start({'name': 'atcoder_facilitator', 'sources': [{'name': 'atcoder_facilitator', 'options':{'matchers': ['matcher_substring']}}]})<CR>
nmap <silent> ;s <Cmd> call ddu#start({'name': 'atcoder_status', 'sources': [{'name': 'atcoder_status', 'options':{'matchers': ['matcher_substring']}}]})<CR>
nmap <silent> ;h <Cmd> call ddu#start({'name': 'vim_variable', 'sources': [
    \ {'name': 'vim_variable', 'params': {'bufnr': bufnr('%')}},
    \ {'name': 'vim_option', 'params': {'bufnr': bufnr('%')}},
    \ {'name': 'vim_function', 'params': {'bufnr': bufnr('%')}},
    \ {'name': 'vim_command', 'params': {'bufnr': bufnr('%')}},
    \ {'name': 'vim_event', 'params': {'bufnr': bufnr('%')}}]})<CR>
nmap <silent> ;c <Cmd> call ddu#start({'name': 'select-sources','sources': [
    \  {'name': 'custom-list',
    \   'params': {'texts': ['append', 'remove', 'head', 'last'], 'callbackId': g:ddcSourceSelectId}}],
    \   'kindOptions': {
    \     'custom-list': {
    \       'defaultAction': 'callback',
    \     },
    \   }}) <CR>
inoremap <C-l><Cmd>call ddu#start({'name': 'ddc'})<CR>
cmap <silent> <C-h> <Cmd>call DduKindVim_typeSetcmdline()<CR>

" ddu-source-custom
let g:allDdcSources = ['around', 'rg', 'buffer', 'file', 'path', 'input', 'cmdline', 'cmdline-history', 'omni', 'nvim-lsp', 'skkeleton']

function s:elem(lst, val) abort
    let isElm = v:false
    for i in a:lst
        if i == a:val
            let isElm = v:true
        endif
    endfor
    return isElm
endfunction

let g:ddcSourceSelectId = denops#callback#register(
    \ {s -> s == 'append' ?
    \  ddu#start({'name': 'select-sources','sources': [
    \  {'name': 'custom-list',
    \   'params': {'texts': g:allDdcSources,'callbackId': g:ddcSourcesAppendId}}]})
    \ : s == 'remove' ?
    \  ddu#start({'name': 'select-sources','sources': [
    \  {'name': 'custom-list',
    \   'params': {'texts': ddc#custom#get_current()['sources'],'callbackId': g:ddcSourcesRemoveId}}]})
    \ : s == 'head' ? 
    \  ddu#start({'name': 'select-sources','sources': [
    \  {'name': 'custom-list',
    \   'params': {'texts': ddc#custom#get_current()['sources'],'callbackId': g:ddcSourcesHeadId}}]}) 
    \ : 
    \  ddu#start({'name': 'select-sources','sources': [
    \  {'name': 'custom-list',
    \   'params': {'texts': ddc#custom#get_current()['sources'],'callbackId': g:ddcSourcesLastId}}]}) })

let g:ddcSourcesAppendId = denops#callback#register(
    \ {s -> !s:elem(ddc#custom#get_current()['sources'], s) ? ddc#custom#set_buffer(extend(ddc#custom#get_buffer(),{'sources': add(ddc#custom#get_current()['sources'], s)})) :
    \ execute(printf('echom "%s is exist"', s), '')})

let g:ddcSourcesRemoveId = denops#callback#register(
    \ {s -> s:elem(ddc#custom#get_current()['sources'], s) ?
    \   ddc#custom#set_buffer(extend(ddc#custom#get_buffer(), {'sources': filter(ddc#custom#get_current()['sources'],{_, val -> val != s})})) : 
    \   execute(printf('echom "%s is not exist"', s), '')})

let g:ddcSourcesHeadId =  denops#callback#register(
    \ {s -> ddc#custom#set_buffer(extend(ddc#custom#get_buffer(), {'sources': insert(filter(ddc#custom#get_current()['sources'],{_, val -> val != s}), s, 0)}))})

let g:ddcSourcesLastId =  denops#callback#register(
    \ {s -> ddc#custom#set_buffer(extend(ddc#custom#get_buffer(), {'sources': add(filter(ddc#custom#get_current()['sources'],{_, val -> val != s}), s)}))})
