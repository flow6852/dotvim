" Mappings
if Global_is_plugged('pum.vim') && ui == 'pum'
    " custom popup window
    " https://zenn.dev/shougo/articles/ddc-vim-pum-vim
    call ddc#custom#patch_global('completionMenu', 'pum.vim')
    inoremap <silent><expr> <Tab>
        \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ? '<Tab>' :
        \ pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' :
        \ ddc#map#manual_complete()
    inoremap <silent><expr><CR>
        \ vsnip#jumpable() ? '<Plug>(vsnip-jump-next)' :
        \ pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' :
        \ '<CR>'
"    inoremap <silent><expr><CR>
"        \ pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' :
"        \ '<CR>'
    inoremap <S-Tab> <Cmd>call pum#map#select_relative(-1)<CR>
    inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
    inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
    inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
    inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

    " for vsnip
    autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)
elseif Global_is_plugged('pum.vim')
    " custom popup window
    " https://zenn.dev/shougo/articles/ddc-vim-pum-vim
    call ddc#custom#patch_global('completionMenu', 'pum.vim')
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
