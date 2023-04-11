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
