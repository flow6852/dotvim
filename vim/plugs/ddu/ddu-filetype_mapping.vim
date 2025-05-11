" hook_source {{{

" custom actions

function! SelectDirInDduFile(dirname, isDir)
    if a:isDir
        call ddu#start({'name': 'split', 'sources': [{'name': 'file', 'options': {'path': a:dirname}}]})
    else
        execute 'e ' . a:dirname
    endif
endfunction

call ddu#custom#action('kind', 'file', 'test',
		    \ { args -> execute('let g:test =  ' . string(args) )})
call ddu#custom#action('kind', 'file', 'open_chain',
            \ { args -> SelectDirInDduFile(get(get(get(args, 'items')[0], 'action'), 'path'), get(get(get(args, 'items')[0], 'action'), 'isDirectory'))})
call ddu#custom#action('kind', 'help', 'vim_type_chain',
            \ {args -> ddu#start({'name': 'vim_type',
                                \ 'input': match(get(get(args, 'items')[0], 'word'), ':') == 0
                                    \ ? get(get(args, 'items')[0], 'word')[1:len(get(get(args, 'items')[0], 'word'))]
                                    \ : get(get(args, 'items')[0], 'word')})})
call ddu#custom#action('source', 'quickfix_history', 'qf_chain',
            \ {args -> ddu#start({'name': 'qf', 'sources': map(copy(get(args, 'items')), 
                               \ {key, val -> {'name': 'qf', 'params': {'what': {'id': get(get(val, 'action'), 'id')}}}})})})
call ddu#custom#action('kind', 'vim_type', 'help_chain',
            \ {args -> ddu#start({'name': 'help', 'input': get(get(args, 'items')[0], 'word')})})

" key mapping 
augroup DduKeyMap
  au!
  autocmd FileType ddu-ff call s:ddu_my_settings()
  autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
augroup End

function! s:ddu_my_settings() abort
  " global 

  nnoremap <buffer><silent> <Esc>
    \ <Cmd>call ddu#ui#async_action('quit')<CR>

  nnoremap <buffer><silent> <Space>
    \ <Cmd>call ddu#ui#async_action('toggleSelectItem')<CR>

  nnoremap <buffer><silent> f
    \ <Cmd>call ddu#ui#async_action('openFilterWindow')<CR>

  nnoremap <buffer><silent> p
    \ <Cmd>call ddu#ui#async_action('preview')<CR>

  nnoremap <buffer><silent> <CR>
    \ <Cmd>call ddu#ui#async_action('itemAction')<CR>

  nnoremap <buffer><silent> r
    \ <Cmd>call ddu#redraw(expand('%'))<CR>

  nnoremap <buffer><silent> v
    \ <Cmd>call ddu#ui#async_action('getItem')<CR>

  " file_rec and vim_type
  nnoremap <buffer><silent> y
    \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'yank'})<CR>

  " atcoder_facilitator
  " file_rec
  nnoremap <buffer><silent> t
    \ if get(b:ddu_ui_item, "kind") == "atcoder_facilitator"
    \   <Cmd>call ddu#ui#multi_actions([['itemAction', {'name': 'runTests', 'params': {'actionFlag': 'Persist'}}], ['preview', {'kind': 'runTests'}]])<CR>
    \ else
    \   <Cmd>call ddu#ui#async_action('itemAction', {'name': 'test'})<CR>
    \ fi

  " file_rec
  nnoremap <buffer> <silent> e
    \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'echo'})<CR>

  " quickfix_history
  nnoremap <buffer> <silent> q
    \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'qf_chain'})<CR>

  " vim_type
  nnoremap <buffer><silent> <C-c>
    \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'setcmdline'})<CR>
    
  " vim_type
  nnoremap <buffer><silent> i
    \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'insert'})<CR>

  " vim_type
  nnoremap <buffer><silent> a
    \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'append'})<CR>

  " url
  nnoremap <buffer><silent> g
    \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'fetchUnstable', 'params': {'showHeader': v:true}})<CR>

  " help
  nnoremap <buffer><silent> h
    \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'vim_type_chain'})<CR>

  " atcoder_facilitator 
  " window
  nnoremap <buffer><silent> s
    \ if get(b:ddu_ui_item, "kind") == "atcoder_facilitator"
    \   <Cmd>call StatusAfterSubmit(v:true)<CR>
    \ else
    \   <Cmd>call ddu#ui#async_action('itemAction', {'name': 'swap'})<CR>
    \ fi

  " directory
  nnoremap <buffer><silent> c
    \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'chdir'})<CR>

endfunction

function! s:ddu_filter_my_settings() abort
  inoremap <buffer> <CR>
        \ <Esc><Cmd>call ddu#ui#async_action('closeFilterWindow')<CR>
  inoremap <buffer> <ESC>
        \ <Esc><Cmd>call ddu#ui#async_action('closeFilterWindow')<CR>
  nnoremap <buffer> <CR>
        \ <Cmd>call ddu#ui#async_action('closeFilterWindow')<CR>
  nnoremap <buffer> <ESC>
        \ <Cmd>call ddu#ui#async_action('closeFilterWindow')<CR>
endfunction

function! StatusAfterSubmit(arg) abort
    call ddu#ui#multi_actions([['itemAction', {'name': 'submit', 'params': {'actionFlag': 'Persist'}}], ['refreshItems'], ['getItem']])
    let l:item = b:ddu_ui_item
    call ddu#ui#sync_action('quit')
    if a:arg
        call ddu#start({'name': 'atcoder_status', 'sources': [{'name': 'atcoder_status', 'params': {'bufnr': get(get(l:item, "action"), "bufnr")}}]})
    else
        echo atcoder_facilitator#statusAfterSubmit(get(get(l:item, "action"), "qdict"), a:arg, 'atcoder_status')
    endif
endfunction

function DduOpenWithPreview(name, sources)
    call ddu#start({'name':a:name, 'sources' : a:sources})
endfunction

augroup mergeqf 
    autocmd!
    autocmd BufWritePost * lua vim.diagnostic.setqflist({open=false})
augroup END

function ForDduSourceOptionsPath(...)
    if isdirectory(expand(expand("<cfile>")))
        return expand("<cfile>")
    else
        return trim(expand(execute("pwd")))
    endif
endfunction
" }}}
