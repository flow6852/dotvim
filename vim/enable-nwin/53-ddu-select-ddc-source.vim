let g:allDdcSources = ['around', 'rg', 'buffer', 'file', 'path', 'input', 'cmdline', 'cmdline-history', 'omni', 'nvim-lsp', 'skkeleton']

let s:grepColSize = 40
let s:grepRowSize = 15
call ddu#custom#patch_local('select-sources', {
    \   'ui': 'ff',
    \   'uiParams': {
    \     'ff': {
    \       'split': 'floating', 
    \       'startFilter': v:false,
    \       'highlights': {'selected': 'Statement'},
    \       'winCol': &columns/4,
    \       'winWidth': &columns/2,
    \       'winRow': &lines/4,
    \       'winHeight': &lines/2,
    \       }
    \   },
    \   'kindOptions': {
    \     'custom-list': {
    \       'defaultAction': 'callback',
    \     },
    \   }
    \ })

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


nmap <silent> ;c <Cmd> call ddu#start({'name': 'select-sources','sources': [
    \  {'name': 'custom-list',
    \   'params': {'texts': ['append', 'remove', 'head', 'last'], 'callbackId': g:ddcSourceSelectId}}]}) <CR>
