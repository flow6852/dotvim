call ddu#custom#patch_local('qf', {
    \   'ui': 'ff',
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
    let conf = {'title':'ddu-qf' , 'titles' : ['Diagnostics','VimTeX', ':vimgrep'], 'withTitle': v:true, 'sep': "|", 'forceUpdate': v:false}
    call mergeqf#setlist(conf)
    call ddu#start({'name': 'qf', 'sources': [{'name': 'qf'}], 'sourceParams': {'qf': conf}})
endfunction

augroup mergeqf 
    autocmd!
    autocmd BufWritePost * lua vim.diagnostic.setqflist({open=false})
augroup END

nmap <silent> ;q <Cmd> call Ddu_qf()<CR>
