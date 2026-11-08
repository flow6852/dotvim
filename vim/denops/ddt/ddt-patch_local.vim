" hook_source {{{
call ddt#custom#patch_global(#{
    \   ui: 'terminal',
    \   uiParams: #{
    \     terminal: #{
    \       command: has('win32') ? ['powershell.exe'] : ['fish'],
    \       promptPattern: has('win32') ? '\f\+>' : '\w*% \?',
    \       split: "floating",
    \       winCol: 0 ,
    \       winWidth: has('nvim') ? &columns : 15 ,
    \       winRow: has('nvim') ? 5*&lines/8-1 : 10,
    \       winHeight: has('nvim') ? 3*&lines/8 : 10 ,
    \     },
    \   },
    \ })
" }}}
