" ddu-option
call ddu#custom#patch_local('filer', {
    \   'ui': 'ff',
    \   'sources': [{'name': 'file_rec', 'params': {}}, {'name': 'buffer'}],
    \   'sourceOptions': {
    \     '_': {
    \       'matchers': ['matcher_substring']
    \     }
    \   },
    \   'uiParams': {
    \     'ff': {
    \       'split': 'floating', 
    \       'startFilter': v:false,
    \       'highlights': {'selected': 'Statement'},
    \       'winCol': &columns/8,
    \       'winWidth': 3*&columns/4,
    \       'winRow': &lines/8,
    \       'winHeight': 3*&lines/4,
    \     }
    \   },
    \   'kindOptions': {
    \     'file_rec': {
    \       'defaultAction': 'open',
    \     },
    \   },
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

" keymapping
" autocmd FileType ddu-filer call s:ddu_my_settings()
" function! s:ddu_my_settings() abort
"   nnoremap <buffer><silent> <CR>
"         \ <Cmd>call ddu#ui#filer#do_action('itemAction')<CR>
"   nnoremap <buffer><silent> <Space>
"         \ <Cmd>call ddu#ui#filer#do_action('toggleSelectItem')<CR>
"   nnoremap <buffer> o
"         \ <Cmd>call ddu#ui#filer#do_action('expandItem',
"         \ {'mode': 'toggle'})<CR>
"   nnoremap <buffer><silent> <Esc>
"         \ <Cmd>call ddu#ui#filer#do_action('quit')<CR>
" endfunction

nmap <silent> ;b <Cmd>call ddu#start({
    \   'name':'filer',
    \   'sources' : [{'name': 'buffer'}],
    \   })<CR>

nmap <silent> ;f <Cmd>call ddu#start({
\   'name': 'filer',
\   'sources': [{'name': 'file_rec'}],
\   'sourceOptions': {
\       '_' :{ 
\           'path': expand(ForDduSourceOptionsPath())
\       }
\   },
\   'sourceParams' : {'file_rec': {'expandSymbolicLink': v:true}},
\ })<CR>

function ForDduSourceOptionsPath(...)
    if isdirectory(expand(expand("<cfile>")))
        return expand("<cfile>")
    else
        return trim(expand(execute("pwd")))
    endif
endfunction


