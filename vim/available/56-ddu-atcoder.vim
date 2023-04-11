let cfg = {
    \   'ui': 'ff',
    \   'sourceOptions': {
    \     '_': {
    \       'matchers': ['matcher_substring'],
    \     },
    \   },
    \   'uiParams' : {
    \     'ff': {
    \       'split': has('nvim') ? 'floating' : 'horizontal',
    \       'startFilter': v:false,
    \       'highlights': {'selected': 'Statement'},
    \       'autoAction': {'name':'preview'},
    \       'winCol': &columns/8 ,
    \       'winWidth': has('nvim') ? 3*&columns/4 : 15,
    \       'winRow': &lines/8,
    \       'winHeight': 10 ,
    \       'previewFloating': has('nvim') ? v:true : v:false,
    \       'previewSplit': has('nvim') ? 'horizontal' : 'no',
    \       'previewWidth': has('nvim') ? 3*&columns/8: 10,
    \       'previewHeight': has('nvim') ? 3*&lines/4 - 10 : 10,
    \       'splitDirection': "topleft"
    \     }
    \  },
    \   'kindOptions': {
    \     '_': {
    \       'defaultAction': 'open',
    \     },
    \   }
    \ }

call ddu#custom#patch_local('atcoder_facilitator', cfg)
call ddu#custom#patch_local('atcoder_status', cfg)

nmap <silent> ;a <Cmd> call ddu#start({'name': 'atcoder_facilitator', 'sources': [{'name': 'atcoder_facilitator', 'options':{'matchers': ['matcher_substring']}}]})<CR>
nmap <silent> ;s <Cmd> call ddu#start({'name': 'atcoder_status', 'sources': [{'name': 'atcoder_status', 'options':{'matchers': ['matcher_substring']}}]})<CR>

call ddu#custom#patch_local('vim_variable', cfg)
nmap <silent> ;h <Cmd> call ddu#start({'name': 'vim_variable', 'sources': [{'name': 'vim_variable', 'params': {'type': 'var', 'bufnr': bufnr('%')}}]})<CR>
