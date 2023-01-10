" You must set the default ui.
" Note: ff ui
" https://github.com/Shougo/ddu-ui-ff
    
" filer-option
" split : floating or vertical
let s:grepColSize = 10
let s:grepRowSize = 5

call ddu#custom#patch_local('grep', {
\   'ui': 'ff',
\   'sourceParams' : {
\     'rg' : {
\       'args': ['--column', '--no-heading', '--json', '--follow'],
\     },
\   },
\   'sourceOptions': {
\     '_': {
\       'matchers': ['matcher_substring'],
\     },
\   },
\   'kindOptions': {
\     'file': {
\       'defaultAction': 'open',
\     },
\   },
\   'uiParams': {
\     'ff': {
\       'split': 'floating', 
\       'startFilter': v:false,
\       'highlights': {'selected': 'Statement'},
\       'winCol': s:grepColSize,
\       'winWidth': &columns - 2 * s:grepColSize,
\       'winRow': s:grepRowSize,
\       'winHeight': &lines - 2 * s:grepRowSize,
\     }
\   }
\ })

" keymapping
autocmd FileType ddu-ff call s:ddu_my_settings()
function! s:ddu_my_settings() abort
  nnoremap <buffer><silent> <CR>
    \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>

  nnoremap <buffer><silent> i
    \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>

  nnoremap <buffer><silent> <Space>
    \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>

  nnoremap <buffer><silent> p
    \ <Cmd>call ddu#ui#ff#do_action('preview')<CR>

  nnoremap <buffer><silent> <Esc>
    \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
function! s:ddu_filter_my_settings() abort
  inoremap <buffer><silent> <CR>
    \ <Esc><Cmd>close<CR>

  inoremap <buffer><silent> <Esc>
    \ <Esc><Cmd>close<CR>

  nnoremap <buffer><silent> <CR>
    \ <Cmd>close<CR>

  nnoremap <buffer><silent> <Esc>
    \ <Cmd>close<CR>
endfunction

nmap <silent> ;g <Cmd>call ddu#start({
\   'name': 'grep',
\   'sources':[
\     {'name': 'rg', 'params': {'input': expand('<cword>'), 'path':expand('.'), 'highlights': 'Search'}}
\   ],
\ })<CR>
