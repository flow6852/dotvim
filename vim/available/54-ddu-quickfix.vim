call ddu#custom#patch_local('qf', {
    \   'ui': 'ff',
    \   'sourceOptions': {
    \     '_': {
    \       'matchers': ['matcher_substring'],
    \     },
    \   },
    \   'uiParams': {
    \     'ff': {
    \       'split': 'floating', 
    \       'startFilter': v:false,
    \       'highlights': {'selected': 'Statement'},
    \       'winCol': &columns/8,
    \       'winWidth': 3*&columns/4,
    \       'winRow': &lines/8,
    \       'winHeight': 3*&lines/8,
    \       'autoAction': {'name':'preview'},
    \       'previewFloating': v:true,
    \       'previewCol': &columns/8,
    \       'previewWidth': 3*&columns/4,
    \       'previewRow': 7*&lines/8-1,
    \       'previewHeight': 3*&lines/8,
    \       }
    \   },
    \   'kindOptions': {
    \     'custom-list': {
    \       'defaultAction': 'open',
    \     },
    \   }
    \ })

function! Ddu_qf() abort
    let conf = {'title':'ddu-qf', 'sources': [ {'what': {'title': 'Diagnostics'}, 'format': '%T|%t', 'isSubst': v:true, 'dup': v:false, 'loc': v:false},
                                             \ {'what': {'title': 'VimTeX'}, 'format': '%T|%t', 'isSubst': v:true, 'dup': v:false, 'loc': v:false},
                                             \ {'what': {'title':':vimgrep'}, 'format': '%T|%t', 'isSubst': v:true, 'dup': v:true, 'loc': v:false}],
                                \ 'forceUpdate': v:false}
    call mergeqf#setlist(conf)
    call ddu#start({'name': 'qf', 'sources': [
            \ {'name': 'qf', 'params': {'what': {'title': ':vimgrep'}, 'isSubst': v:true, 'format': '%T|%y|%t', 'dup': v:true}}]})
endfunction

augroup mergeqf 
    autocmd!
    autocmd BufWritePost * lua vim.diagnostic.setqflist({open=false})
augroup END

let format='%T|%p|%y|%t'

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

nmap <silent> ;v <Cmd> call ddu#start({'name': 'qf', 'sources': [
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
