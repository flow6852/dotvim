"  Customize global settings
" Use around source.
" https://github.com/Shougo/ddc-around
let g:sources = ['around', 'rg', 'buffer', 'file', 'input']
let autoCompleteEvents = ['InsertEnter', 'TextChangedI', 'TextChangedP']
let g:ui = 'pum'

call ddc#custom#patch_global('ui', ui) 
call pum#set_option('auto_select', v:true)
call ddc#custom#patch_global('autoCompleteEvents', autoCompleteEvents) 
call ddc#custom#patch_global('sources', sources)
call ddc#custom#patch_global('backspaceCompletion', v:true)

" Use matcher_head and sorter_rank.
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
" https://github.com/tani/ddc-fuzzy
" Global Option
call ddc#custom#patch_global('sourceOptions', {
      \ '_': { 'matchers': ['matcher_editdistance'],
      \        'converters': ['converter_remove_overlap'],
      \        'isVolatile': v:true,
      \ },
      \ 'around': {'mark': '[around]'},
      \ 'file': {'mark': '[file]'},
      \ 'buffer': {'mark': '[buffer]'},
      \ 'path': {'mark': '[path]'},
      \ 'input': {'mark': '[input]'},
      \ 'line': { 'mark': '[line]' },
      \ 'rg': { 'mark': '[ripgrep]' },
      \ })

call ddc#custom#patch_global('sourceParams', {
      \ 'around': {'maxSize': 10000},
      \ 'buffer': {
      \   'requireSameFiletype': v:false,
      \   'limitBytes': 5000000,
      \   'fromAltBuf': v:true,
      \   'forceCollect': v:true,
      \ },
      \ 'path': {
      \   'cmd': ['fd', '--max-depth', '5'],
      \ },
      \ 'file': {
      \   'followSymlinks': v:true,
      \   'projFromCwdMaxItems': [0, 0],
      \   'projFromBufMaxItems': [0, 0],
      \ },
      \ 'line': { 'maxSize': 10 },
      \ })

call ddc#custom#patch_global('filterParams', {
  \   'converter_fuzzy': {
  \     'hlGroup': 'SpellBad'
  \   },
  \   'matcher_editdistance': {'showScore': v:true, 'diffLen': 0, 'limit': 100},
  \ })


" Use ddc.
call ddc#enable()

" Use popup preview
call popup_preview#enable()
call signature_help#enable()

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
