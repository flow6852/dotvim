call ddu#custom#patch_local('qf', {
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
    \       'defaultAction': 'open',
    \     },
    \   }
    \ })

nmap <silent> ;q <Cmd> call ddu#start({'name': 'qf','sources': [{'name': 'qf'}]}) <CR>
