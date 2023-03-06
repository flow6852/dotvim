call ddu#custom#patch_local('qf', g:ddu_ui_horizontal_cfg)

function! MergeQf() abort
    let conf = {'title':'ddu-qf', 'sources': [ {'what': {'title': 'Diagnostics'}, 'format': '%T|%t', 'isSubst': v:true, 'dup': v:false, 'loc': -1},
                                             \ {'what': {'title': 'VimTeX'}, 'format': '%T|%t', 'isSubst': v:true, 'dup': v:false, 'loc': -1},
                                             \ {'what': {'title':':vimgrep'}, 'format': '%T|%t', 'isSubst': v:true, 'dup': v:true, 'loc': -1},
                                             \ {'what': {'title':':vim'}, 'isSubst': v:true, 'dup': v:true}],
                                \ 'forceUpdate': v:false}
    call mergeqf#setlist(conf)
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
