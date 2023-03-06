function ForDduSourceOptionsPath(...)
    if isdirectory(expand(expand("<cfile>")))
        return expand("<cfile>")
    else
        return trim(expand(execute("pwd")))
    endif
endfunction

" ddu-option
call ddu#custom#patch_local('filer', extend(g:ddu_ui_vertical_cfg, {
    \   'sources': [{'name': 'file_rec', 'params': {'expandSymbolicLink': v:true}}, {'name': 'buffer'}],
    \   'sourceOptions': {
    \     'file_rec': {
    \       'path': expand(ForDduSourceOptionsPath())
    \     }
    \   },
    \ }))

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
  inoremap <buffer><silent> <CR> <Esc><Cmd>close<CR>
  inoremap <buffer><silent> <Esc> <Esc><Cmd>close<CR>

  nnoremap <buffer><silent> <CR> <Cmd>close<CR>
  nnoremap <buffer><silent> <Esc> <Cmd>close<CR>

endfunction

function DduOpenWithPreview(name, sources)
    call ddu#start({'name':a:name,'sources' : a:sources})
endfunction


nmap <silent> ;b <Cmd>call DduOpenWithPreview('filer', [{'name': 'buffer'}])<CR>
nmap <silent> ;f <Cmd>call DduOpenWithPreview('filer', [{'name': 'file_rec', 'params': {'expandSymbolicLink': v:true}}])<CR>
