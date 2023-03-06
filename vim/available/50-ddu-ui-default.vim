" You must set the default ui.
" Note: ff ui
" https://github.com/Shougo/ddu-ui-ff
    
" filer-option
" split : floating or vertical
call ddu#custom#patch_global({
\   'ui': 'ff',
\   'kindOptions': {
\     'file': {
\       'defaultAction': 'open',
\     },
\   },
\ })

" fuze finder spliter
if has('nvim')
    let g:ddu_ui_vertical_cfg = {
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
    \       'winWidth': 3*&columns/8,
    \       'winRow': &lines/8,
    \       'winHeight': 3*&lines/4,
    \       'autoAction': {'name':'preview'},
    \       'previewFloating': v:true,
    \       'previewSplit': 'vertical',
    \       'previewWidth': 3*&columns/8,
    \       'previewHeight': 3*&lines/4,
    \     }
    \   },
    \   'kindOptions': {
    \     'file_rec': {
    \       'defaultAction': 'open',
    \     },
    \   }
    \ }

    let g:ddu_ui_horizontal_cfg = {
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
    \       'previewSplit': 'horizontal',
    \       'previewWidth': 3*&columns/4,
    \       'previewHeight': 3*&lines/8,
    \     }
    \   },
    \   'kindOptions': {
    \     'file_rec': {
    \       'defaultAction': 'open',
    \     },
    \   }
    \ }
else
    let g:ddu_ui_vertical_cfg = {
    \   'ui': 'ff',
    \   'sourceOptions': {
    \     '_': {
    \       'matchers': ['matcher_substring'],
    \     },
    \   },
    \   'uiParams': {
    \     'ff': {
    \       'split': 'vertical',
    \       'splitDirection': 'topleft',
    \       'startFilter': v:false,
    \       'highlights': {'selected': 'Statement'},
    \       'winWidth': 20,
    \       'autoAction': {'name':'preview'},
    \       'previewSplit': 'no',
    \     }
    \   },
    \   'kindOptions': {
    \     'file_rec': {
    \       'defaultAction': 'open',
    \     },
    \   }
    \ }

    let g:ddu_ui_horizontal_cfg = {
    \   'ui': 'ff',
    \   'sourceOptions': {
    \     '_': {
    \       'matchers': ['matcher_substring'],
    \     },
    \   },
    \   'uiParams': {
    \     'ff': {
    \       'split': 'horizontal', 
    \       'startFilter': v:false,
    \       'highlights': {'selected': 'Statement'},
    \       'winHeight': 10,
    \       'autoAction': {'name':'preview'},
    \       'previewSplit': 'no',
    \     }
    \   },
    \   'kindOptions': {
    \     'file_rec': {
    \       'defaultAction': 'open',
    \     },
    \   }
    \ }
endif
