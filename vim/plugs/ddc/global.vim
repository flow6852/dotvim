" hook_source {{{

call pum#set_option('auto_select', v:false)

function DdcMappingChange(isAutoSelected)
    if Global_is_plugged('pum.vim') && g:ui == 'pum'
        " custom popup window
        " https://zenn.dev/shougo/articles/ddc-vim-pum-vim
        inoremap <silent><expr><M-j>
            \ pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' :
            \ vsnip#jumpable() ? '<Plug>(vsnip-jump-next)' :
            \ vsnip#expandable() ? '<Plug>(vsnip-expand)' :
            \ '<Cmd>echom "Failed completion"<CR>'
        inoremap <M-y>   <Cmd>call pum#map#confirm()<CR>
        inoremap <M-e>   <Cmd>call pum#map#cancel()<CR>
    
        " for vsnip
        " autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)

        if (a:isAutoSelected)
            inoremap <expr><M-n>
                \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
                \ ddc#map#manual_complete()
            inoremap <expr><M-u>   '<Cmd>call pum#map#insert_relative(-1)<CR>'
        else
            inoremap <expr><M-n>   
                \ pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' :
                \ ddc#map#manual_complete()
            inoremap <expr><M-u>   '<Cmd>call pum#map#select_relative(-1)<CR>'
        endif
    elseif Global_is_plugged('pum.vim')
        " custom popup window
        " https://zenn.dev/shougo/articles/ddc-vim-pum-vim
        " call ddc#custom#patch_global('completionMenu', 'pum.vim')
        inoremap <M-y>   <Cmd>call pum#map#confirm()<CR>
        inoremap <M-n>   <Cmd>call pum#map#select_relative(+1)<CR>
        inoremap <M-u>   <Cmd>call pum#map#select_relative(-1)<CR>
        inoremap <M-e>   <Cmd>call pum#map#cancel()<CR>
    
        " for vsnip
        " autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)
    endif
endfunction

call ddc#custom#patch_global(#{
                             \ backspaceCompletion: v:true,
                             \ autoCompleteEvents: ['InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineEnter', 'CmdlineChanged'],
                             \ ui: g:ui,
                             \ filterParams : #{
                             \   converter_fuzzy: #{
                             \     hlGroup: 'SpellBad'
                             \   },
                             \   matcher_editdistance: #{showScore: v:true, diffLen: 0, limit: 100},
                             \ }
                             \})

call DdcMappingChange(v:false)

call ddc#enable()
" }}}
