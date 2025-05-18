" hook_source {{{
function DduKindVim_typeSetcmdline()
    let getcmdline = getcmdline()
    let getcmdpos = getcmdpos()
    call feedkeys("\<Esc>", 't')
    call ddu#start(#{name: 'split',
        \ sources:[ #{name: 'vim_variable'},
                  \ #{name: 'vim_option'},
                  \ #{name: 'vim_function'},
                  \ #{name: 'vim_command'},
                  \ #{name: 'vim_event'}],
        \ actionParams: #{getcmdline: getcmdline, getcmdpos: getcmdpos}})
endfunction

let g:qfFormat = "%b|col\:%c|line\:%l|%T|%t"

nnoremap <silent> ;b <Cmd>call ddu#start(#{name: 'split', sources: [#{name: 'buffer', params : #{expandSymbolicLink: v:true}}, #{name: 'terminal'}]})<CR>
nnoremap <silent> ;f <Cmd>call ddu#start(#{name: 'split', sources: [#{name: 'file', params : #{expandSymbolicLink: v:true, ignoreDirectories: v:true}}, #{name: 'directory', params : #{expandSymbolicLink: v:true}}]})<CR>
nnoremap <silent> ;r <Cmd>call ddu#start(#{name: 'split', sources: [#{name: 'file_rec', params : #{expandSymbolicLink: v:true}}]})<CR>
nnoremap <silent> ;rg <Cmd>call ddu#start(#{name: 'split',
                                    \ sources:[#{name: 'rg', 
                                    \           params: #{input: expand('<cword>'),
                                    \                     path:expand('.'),
                                    \                     highlights: 'Search',
                                    \                     args: ['--column', '--no-heading', '--json', '--follow']
                                    \ }}]})<CR>
nnoremap <silent> ;qf <Cmd>call ddu#start(#{name: 'split', sources: [{'name': 'qf'}]})<CR>
nnoremap <silent> ;qh <Cmd>call ddu#start(#{name: 'split', sources: [{'name': 'quickfix_history'}]})<CR>
nnoremap <silent> ;v <Cmd>call ddu#start(#{
            \ name: 'split',
            \ sources: [
            \   #{name: 'qf', 
            \     params: #{what: #{title: ':vimgrep'},
            \               isSubst: v:true,
            \               format: g:qfFormat,
            \               dup: v:true}},
            \   #{name: 'qf', 
            \     params: #{what: #{title: ':lvimgrep'},
            \               isSubst: v:true,
            \               format: g:qfFormat,
            \               nr: 0,
            \               dup: v:true }}
            \ ]})<CR>
nnoremap <silent> ;u <Cmd>call ddu#start(#{name: 'split', sources: [#{name: 'url', params: #{ignoredDirectories: '.git'}}]})<CR>
nnoremap <silent> ;a <Cmd>call ddu#start(#{name: 'split', sources: [#{name: 'atcoder_facilitator', 'params':#{bufnr: bufnr("%")}}]})<CR>
nnoremap <silent> ;s <Cmd>call ddu#start(#{name: 'split', sources: [#{name: 'atcoder_status', 'params':#{bufnr: bufnr("%")}}]})<CR>
nnoremap <silent> ;h <Cmd>call ddu#start(#{name: 'split',
            \ sources: [ 
                \ #{name: 'vim_variable'},
                \ #{name: 'vim_option'},
                \ #{name: 'vim_function', params: #{pattern: 'ddu'}},
                \ #{name: 'vim_command'},
                \ #{name: 'vim_event'}
            \ ]}) <CR>
nnoremap <silent> ;m <Cmd>call ddu#start(#{name: 'split', sources: [#{name: 'markdown'}]})<CR>
nnoremap <silent> ;c <Cmd>call ddu#start(#{
    \  {name: 'custom-list',
    \   params: #{texts: ['append', 'remove', 'head', 'last'], callbackId: g:ddcSourceSelectId}}],
    \   kindOptions: #{
    \     custom-list: #{
    \       defaultAction: 'callback',
    \     },
    \   }}) <CR>
inoremap <C-d><C-d><C-c> <Cmd>call ddu#start(#{name: 'ddc'})<CR>
nnoremap <silent> ;w <Cmd>call ddu#start(#{name: 'split', sources: [#{name: 'window'}]})<CR>
nnoremap <silent> ;gs <Cmd>call ddu#start(#{name: 'split', sources: [#{name: 'git_status'}]})<CR>
nnoremap <silent> ;gl <Cmd>call ddu#start(#{name: 'split', sources: [#{name: 'git_log'}]})<CR>
nnoremap <silent> ;gd <Cmd>call ddu#start(#{name: 'split', sources: [#{name: 'git_diff'}]})<CR>
nnoremap <silent> ;ld <Cmd>call ddu#start(#{name: 'split', sources: [#{name: 'lsp_definition', params: #{clientName: 'nvim-lsp'}} ]})<CR>
nnoremap <silent> ;lr <Cmd>call ddu#start(#{name: 'split', sources: [#{name: 'lsp_references', params: #{clientName: 'nvim-lsp'}} ]})<CR>
nnoremap <silent> ;lc <Cmd>call ddu#start(#{name: 'split', sources: [#{name: 'lsp_codeAction', params: #{clientName: 'nvim-lsp'}} ]})<CR>
cnoremap <silent> <C-h> <Cmd>call DduKindVim_typeSetcmdline()<CR>

" ddu-source-custom
let g:allDdcSources = ['around', 'rg', 'buffer', 'file', 'path', 'input', 'cmdline', 'cmdline_history', 'omni', 'nvim-lsp', 'skkeleton']

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
" }}}
