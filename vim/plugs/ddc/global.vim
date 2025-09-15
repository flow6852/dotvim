" hook_source {{{

let s:pum_option = #{
    \   auto_select: v:false,
    \   max_height: 10
    \ }
call pum#set_option(s:pum_option)

function RotateDdcSources()
    let l:set_buffer = ddc#custom#get_current()

    if ! (len(l:set_buffer['sources']) < 2)
        let l:lnum = line('.')
        let l:col = col('.')
        let l:line = getline('.')
        call setline('.', l:line . '0')
        let l:set_buffer["sources"] = add(slice(l:set_buffer['sources'], 1), l:set_buffer['sources'][0])
        call ddc#custom#set_buffer(l:set_buffer)
        call ddc#hide()
        call setline('.', l:line)
    endif
endfunction

inoremap <expr><M-b> '<Cmd>call RotateDdcSources()<CR>'
cnoremap <expr><M-b> '<Cmd>call RotateDdcSources()<CR>'

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
                             \ autoCompleteEvents: ["TextChangedI", "TextChangedP", "CmdlineChanged"],
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
