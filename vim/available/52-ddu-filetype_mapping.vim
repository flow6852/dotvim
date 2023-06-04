" keymapping
augroup DduKeyMap
  au!
  autocmd FileType ddu-ff call s:ddu_my_settings()
  autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
augroup End

function! s:ddu_my_settings() abort
  " global 

  nnoremap <buffer><silent> <Esc>
    \ <Cmd>call ddu#ui#do_action('quit')<CR>

  nnoremap <buffer><silent> <Space>
    \ <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>

  nnoremap <buffer><silent> i
    \ <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>

  nnoremap <buffer><silent> p
    \ <Cmd>call ddu#ui#do_action('preview')<CR>

  nnoremap <buffer><silent> <CR>
    \ <Cmd>call ddu#ui#do_action('itemAction')<CR>

  nnoremap <buffer><silent> r
    \ <Cmd>call ddu#redraw(expand('%'))<CR>

  nnoremap <buffer><silent> v
    \ <Cmd>call ddu#ui#do_action('getItem')<CR>

  if b:ddu_ui_name == "filer"
    nnoremap <buffer><silent> y
      \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'yank'})<CR>
  elseif b:ddu_ui_name == "grep"
  elseif b:ddu_ui_name == "qf"
  elseif b:ddu_ui_name == "quickfix_history"
    nnoremap <buffer> ;q
      \ <Cmd>call DduChain('qf')<CR>
    nnoremap <buffer> ;e
      \ <Cmd>echom "test"<CR>
  elseif b:ddu_ui_name == "vim_type"
    " file
    nnoremap <buffer><silent> ;h
      \ <Cmd>call DduChain('help')<CR>

    nnoremap <buffer><silent> <C-c>
      \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'setcmdline'})<CR>

    nnoremap <buffer><silent> y
      \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'yank'})<CR>
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
      \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'fetchUnstable', 'params': {'showHeader': v:true}})<CR>
  elseif b:ddu_ui_name == "help"
    nnoremap <buffer><silent> ;h
      \ <Cmd>call DduChain('vim_type')<CR>
  elseif b:ddu_ui_name == "window"
    nnoremap <buffer><silent> ;s
      \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'swap'})<CR>
  endif
endfunction

function! s:ddu_filter_my_settings() abort
  inoremap <buffer> <CR>
        \ <Esc><Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
  inoremap <buffer> <ESC>
        \ <Esc><Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
  nnoremap <buffer> <CR>
        \ <Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
  nnoremap <buffer> <ESC>
        \ <Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
endfunction

function! StatusAfterSubmit(arg) abort
    call ddu#ui#multi_actions([['itemAction', {'name': 'submit', 'params': {'actionFlag': 'Persist'}}], ['refreshItems'], ['getItem']])
    let l:item = b:ddu_ui_item
    call ddu#ui#do_action('quit')
    if a:arg
        call ddu#start({'name': 'atcoder_status', 'sources': [{'name': 'atcoder_status', 'params': {'bufnr': get(get(l:item, "action"), "bufnr")}}]})
        " call atcoder_facilitator#statusAfterSubmit(get(get(l:item, "action"), "qdict"), a:arg, 'atcoder_status')
        " let l:item = ddu#ui#get_item()
        " echom l:item
        " echom get(l:item, "word")
        " echom match(get(l:item, "word"), "WJ")
        " echom match(get(l:item, "word"), "/")
        " while match(get(l:item, "word"), "WJ") > 0 || match(get(l:item, "word"), "/") > 0
        "     echom "redraw"
        "     call ddu#redraw('atcoder_status', {'refreshItems': v:true})
        "     execute "3sleep"
        "     let item = ddu#ui#get_item()
        " endwhile
    else
        echo atcoder_facilitator#statusAfterSubmit(get(get(l:item, "action"), "qdict"), a:arg, 'atcoder_status')
    endif
endfunction

function DduOpenWithPreview(name, sources)
    call ddu#start({'name':a:name, 'sources' : a:sources})
endfunction

function! DduChain(arg)
    let l:item = ddu#ui#get_item()
    if get(l:item, '__sourceName') == 'help'
        call ddu#ui#sync_action('quit')
        let l:word = get(l:item, 'word')
        if match(l:word, ":") == 0
            let l:word = l:word[1:len(l:word)]
            call ddu#start({'name': a:arg, 'input': l:word})
        endif
    elseif get(l:item, '__sourceName') == 'quickfix_history'
        let l:items = ddu#ui#get_selected_items()
        call ddu#ui#sync_action('quit')
        call ddu#start({'name': a:arg,
                    \       'sources': map(copy(l:items), {key, val -> {'name': 'qf', 
                    \                                                   'params': {'what': {'id': get(get(val, 'action'), 'id')}}}})})
    endif
endfunction

" Mappings

function DduMappingChange(isAutoSelected)
    if Global_is_plugged('pum.vim') && g:ui == 'pum'
        " custom popup window
        " https://zenn.dev/shougo/articles/ddc-vim-pum-vim
        inoremap <silent><expr><CR>
            \ pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' :
            \ vsnip#jumpable() ? '<Plug>(vsnip-jump-next)' :
            \ vsnip#expandable() ? '<Plug>(vsnip-expand)' :
            \ '<CR>'
        inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
        inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
    
        " for vsnip
        autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)

        if (a:isAutoSelected)
            inoremap <silent><expr> <Tab>
                \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ? '<Tab>' :
                \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
                \ ddc#map#manual_complete()
            inoremap <expr><S-Tab> '<Cmd>call pum#map#insert_relative(-1)<CR>'
            inoremap <expr><C-n>   '<Cmd>call pum#map#insert_relative(+1)<CR>'
            inoremap <expr><C-p>   '<Cmd>call pum#map#insert_relative(-1)<CR>'
        else
            inoremap <silent><expr> <Tab>
                \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ? '<Tab>' :
                \ pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' :
                \ ddc#map#manual_complete()
            inoremap <expr><S-Tab> '<Cmd>call pum#map#select_relative(-1)<CR>'
            inoremap <expr><C-n>   '<Cmd>call pum#map#select_relative(+1)<CR>'
            inoremap <expr><C-p>   '<Cmd>call pum#map#select_relative(-1)<CR>'

        endif
    elseif Global_is_plugged('pum.vim')
        " custom popup window
        " https://zenn.dev/shougo/articles/ddc-vim-pum-vim
        " call ddc#custom#patch_global('completionMenu', 'pum.vim')
        inoremap <silent><expr> <Tab>
            \ pumvisible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
            \ '<Tab>' : ddc#map#manual_complete()
        inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
        inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
        inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
        inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
        inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
    
        " for vsnip
        autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)
    else 
        " <S-TAB>: completion.
        inoremap <silent><expr> <S-TAB>
        \ pumvisible() ? '<C-n>' :
        \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
        \ '<S-TAB>' : ddc#map#manual_complete()
        
        " <C-TAB>: completion back.
        inoremap <expr><C-TAB> pumvisible() ? '<C-p>' : '<C-h>'
    endif
endfunction

call DduMappingChange(v:false)

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
