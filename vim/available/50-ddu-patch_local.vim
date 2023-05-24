" You must set the default ui.
" Note: ff ui
" https://github.com/Shougo/ddu-ui-ff
    
" filer-option
" split : floating or vertical

" fuze finder spliter

function Ddu_custom_cfg(split, width, height, isPreview, previewSplit, previewWidth, previewHeight)
    let uiParams = {
    \     'ff': {
    \       'split': has('nvim') ? a:split : a:previewSplit,
    \       'startFilter': v:false,
    \       'highlights': {'selected': 'Statement'},
    \       'autoAction': a:isPreview ? {'name':'preview'} : {},
    \       'winCol': &columns/8 ,
    \       'winWidth': a:split == 'floating' && has('nvim')  ? a:width : 15 ,
    \       'winRow': &lines/8,
    \       'winHeight': a:split == 'floating' && has('nvim') ? a:height : 10 ,
    \       'previewFloating': a:split == 'floating' && has('nvim') ? a:isPreview : v:false,
    \       'previewSplit': has('nvim') ? a:previewSplit : 'no',
    \       'previewWidth': a:split == 'floating' && has('nvim') ? a:previewWidth : 10,
    \       'previewHeight': a:split == 'floating' && has('nvim') ? a:previewHeight : 10,
    \       'splitDirection': a:previewSplit == 'vertical' ? "topleft": "botright"
    \     }
    \  }

    let ret = {
    \   'ui': 'ff',
    \   'sourceOptions': {
    \     '_': {
    \       'matchers': ['matcher_substring'],
    \     },
    \   },
    \   'uiParams' : uiParams,
    \   'kindOptions': {
    \     '_': {
    \       'defaultAction': 'open',
    \     },
    \   }
    \ }

    return ret
endfunction
let format='%T|%p|%y|%t'

" vertical -> 3*&columns/8
" horizontal -> 3*&lines/8
" call Ddu_custom_cfg(split, width, height, isPreview, previewSplit, prevWidth, prevHeight)
call ddu#custom#patch_local('filer', Ddu_custom_cfg('floating', 15, 6*&lines/8, v:true, 'vertical',6*&columns/8-15, 6*&lines/8))
call ddu#custom#patch_local('grep', Ddu_custom_cfg('floating', 6*&columns/8, 3*&lines/8, v:true, 'horizontal', 6*&columns/8, 3*&lines/8))
call ddu#custom#patch_local('qf', Ddu_custom_cfg('floating',  6*&columns/8, 3*&lines/8, v:true, 'horizontal', 6*&columns/8, 3*&lines/8))
call ddu#custom#patch_local('vim_type', extend(
    \ Ddu_custom_cfg('floating',  3*&columns/4, 10, v:true, 'horizontal', 3*&columns/8, 3*&lines/4 - 10), 
    \ {'sources': [ {'name': 'vim_variable', 'params': {'bufnr': bufnr('%')}},
                  \ {'name': 'vim_option', 'params': {'bufnr': bufnr('%')}},
                  \ {'name': 'vim_function', 'params': {'bufnr': bufnr('%')}},
                  \ {'name': 'vim_command', 'params': {'bufnr': bufnr('%')}},
                  \ {'name': 'vim_event', 'params': {'bufnr': bufnr('%')}}]}))

call ddu#custom#patch_local('atcoder_facilitator', Ddu_custom_cfg('floating',  3*&columns/4, 10, v:true, 'horizontal', 3*&columns/8, 3*&lines/4 - 10))
call ddu#custom#patch_local('atcoder_status', Ddu_custom_cfg('floating',  3*&columns/4, 10, v:true, 'horizontal', 3*&columns/8, 3*&lines/4 - 10))
call ddu#custom#patch_local('select-sources', extend(Ddu_custom_cfg('vertical', 3*&columns/4, 10, v:false, 'horizontal', 3*&columns/8, 3*&lines/4 - 10), {
    \   'kindOptions': {
    \     'custom-list': {
    \       'defaultAction': 'callback',
    \     },
    \   }
    \ }))
call ddu#custom#patch_local('ddc', #{
\   name: 'ddc',
\   ui: 'ff',
\   input: matchstr(getline('.')[: col('.') - 1], '\k*$'),
\   sources: [
\     #{ name: 'ddc', options: #{ defaultAction: 'complete' } },
\   ],
\   uiParams: #{
\     ff: #{
\       startFilter: v:true,
\       replaceCol: match(getline('.')[: col('.') - 1], '\k*$') + 1,
\     },
\   },
\ })
call ddu#custom#patch_local('url', Ddu_custom_cfg('floating',  3*&columns/4, 10, v:true, 'horizontal', 3*&columns/8, 3*&lines/4 - 10))
call ddu#custom#patch_local('help', extend(Ddu_custom_cfg('floating',  3*&columns/4, 10, v:true, 'horizontal', 3*&columns/8, 3*&lines/4 - 10), {'sources': [{'name': 'help'}]}))
call ddu#custom#patch_local('window', extend(Ddu_custom_cfg('floating', 15, 6*&lines/8, v:true, 'vertical',6*&columns/8-15, 6*&lines/8), {'sources': [{'name': 'window'}]}))
