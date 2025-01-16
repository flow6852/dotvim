" hook_source {{{

call pum#set_option('auto_select', v:false)

function DdcMappingChange(isAutoSelected)
    if Global_is_plugged('pum.vim') && g:ui == 'pum'
        " custom popup window
        " https://zenn.dev/shougo/articles/ddc-vim-pum-vim
        inoremap <silent><expr><C-j>
            \ pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' :
            \ vsnip#jumpable() ? '<Plug>(vsnip-jump-next)' :
            \ vsnip#expandable() ? '<Plug>(vsnip-expand)' :
            \ '<Cmd>echom "Failed completion"<CR>'
        inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
        inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
    
        " for vsnip
        " autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)

        if (a:isAutoSelected)
            inoremap <expr><C-n>
                \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
                \ ddc#map#manual_complete()
            inoremap <expr><C-m>   '<Cmd>call pum#map#insert_relative(-1)<CR>'
        else
            inoremap <expr><C-n>   
                \ pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' :
                \ ddc#map#manual_complete()
            inoremap <expr><C-m>   '<Cmd>call pum#map#select_relative(-1)<CR>'
        endif
    elseif Global_is_plugged('pum.vim')
        " custom popup window
        " https://zenn.dev/shougo/articles/ddc-vim-pum-vim
        " call ddc#custom#patch_global('completionMenu', 'pum.vim')
        inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
        inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
        inoremap <C-m>   <Cmd>call pum#map#select_relative(-1)<CR>
        inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
    
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
