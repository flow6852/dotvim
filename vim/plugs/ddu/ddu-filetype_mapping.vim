" hook_source {{{
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

  if b:ddu_ui_name == "filer"
    nnoremap <buffer><silent> y
      \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'yank'})<CR>
    nnoremap <buffer><silent> t
      \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'test'})<CR>
    nnoremap <buffer> <silent> e
      \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'echo'})<CR>
  elseif b:ddu_ui_name == "grep"
  elseif b:ddu_ui_name == "qf"
  elseif b:ddu_ui_name == "quickfix_history"
    nnoremap <buffer> ;q
                \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'qf_chain'})<CR>
    nnoremap <buffer> ;e
      \ <Cmd>echom "test"<CR>
  elseif b:ddu_ui_name == "vim_type"
    " file
    nnoremap <buffer><silent> ;h
      \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'help_chain'})<CR>

    nnoremap <buffer><silent> <C-c>
      \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'setcmdline'})<CR>

    nnoremap <buffer><silent> y
      \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'yank'})<CR>
    
    nnoremap <buffer><silent> i
      \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'insert'})<CR>

    nnoremap <buffer><silent> a
      \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'append'})<CR>
  elseif b:ddu_ui_name == "atcoder_facilitator"
    " submit
    nnoremap <buffer><silent> s
      \ <Cmd>call StatusAfterSubmit(v:true)<CR>

    nnoremap <buffer><silent> t
      \ <Cmd>call ddu#ui#multi_actions([['itemAction', {'name': 'runTests', 'params': {'actionFlag': 'Persist'}}], ['preview', {'kind': 'runTests'}]])<CR>
  elseif b:ddu_ui_name == "atcoder_status"
  elseif b:ddu_ui_name == "select-sources"
  elseif b:ddu_ui_name == "ddc"
  elseif b:ddu_ui_name == "url"
    " GET
    nnoremap <buffer><silent> g
      \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'fetchUnstable', 'params': {'showHeader': v:true}})<CR>
  elseif b:ddu_ui_name == "help"
    nnoremap <buffer><silent> ;h
        \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'vim_type_chain'})<CR>
  elseif b:ddu_ui_name == "window"
    nnoremap <buffer><silent> ;s
      \ <Cmd>call ddu#ui#async_action('itemAction', {'name': 'swap'})<CR>
  endif
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
