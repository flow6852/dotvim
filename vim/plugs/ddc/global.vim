" hook_source {{{
call pum#set_option('auto_select', v:false)
let l:autoCompleteEvents = ['InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineEnter', 'CmdlineChanged']
let l:sources = ['lsp', 'vsnip', 'around', 'buffer', 'file', 'input']
let l:sourceOptions = #{
      \ _: #{ matchers: ['matcher_editdistance'],
      \       converters: ['converter_remove_overlap'],
      \       isVolatile: v:true,
      \ },
      \ around: #{mark: '[around]'},
      \ buffer: #{mark: '[buffer]'},
      \ path: #{mark: '[path]'},
      \ input: #{mark: '[input]'},
      \ line: #{mark: '[line]' },
      \ vsnip : #{mark: '[vsnip]',
      \           dup: "keep"},
      \ file: #{ mark : '[file]', isVolatile: v:true, minAutoCompleteLength: 0, forceCompletionPattern: '\S/\S*'},
      \ lsp: #{mark: 'lsp', forceCompletionPattern: '\.\w*|:\w*|->\w*', dup: "keep"}
      \ }
let l:sourceParams = #{
      \ around: #{maxSize: 10000},
      \ buffer: #{
      \   requireSameFiletype: v:false,
      \   limitBytes: 5000000,
      \   fromAltBuf: v:true,
      \   forceCollect: v:true,
      \ },
      \ path: #{
      \   cmd: ['fd', '--max-depth', '5'],
      \ },
      \ file: #{
      \   followSymlinks: v:true,
      \   projFromCwdMaxItems: [0, 0],
      \   projFromBufMaxItems: [0, 0],
      \ },
      \ line: #{maxSize: 10 },
      \ input: #{maxSize: 10},
      \ lsp: #{
      \   lspEngine: 'nvim-lsp', 
      \   snippetEngine: denops#callback#register({
      \         body -> vsnip#anonymous(body)
      \   }),
      \   enableResolveItem: v:true,
      \   enableAdditionalTextEdit: v:true,
      \   }
      \ }

if executable('rg') 
    let l:sources = add(l:sources, 'rg')
    let l:sourceOptions = extend(l:sourceOptions, {'rg': { 'mark': '[ripgrep]' }})
endif

" if Global_is_plugged('ddc-nvim-lsp') && has('nvim')
"     " https://github.com/Shougo/ddc-nvim-lsp
"     let l:sources = insert(l:sources, 'nvim-lsp', 0)
"     let l:sourceOptions = extend(l:sourceOptions, #{nvim-lsp: #{mark: '[lsp]', forceCompletionPattern: '\.\w*|:\w*|->\w*'}})
"     let l:sourceParams = extend(l:sourceParams, #{nvim-lsp: #{kindLabels: #{Class: '[Class]'}}
"     \ })
" elseif Global_is_plugged('ddc-vim-lsp')
"     let sources = add(sources, 'vim-lsp')
"     let l:sourceOptions = extend(l:sourceOptions, #{vim-lsp: #{mark: 'lsp',}})
" endif

call ddc#custom#patch_global(#{sources: l:sources,
                             \ backspaceCompletion: v:true,
                             \ sourceOptions: l:sourceOptions,
                             \ autoCompleteEvents: l:autoCompleteEvents,
                             \ ui: g:ui,
                             \ sourceParams: l:sourceParams,
                             \ filterParams : #{
                             \   converter_fuzzy: #{
                             \     hlGroup: 'SpellBad'
                             \   },
                             \   matcher_editdistance: #{showScore: v:true, diffLen: 0, limit: 100},
                             \ }
                             \})

"autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)

"" Mappings
" Mappings

function DdcMappingChange(isAutoSelected)
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
        " autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)

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
        " autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)
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

call DdcMappingChange(v:false)

call ddc#enable()
call popup_preview#enable()
call signature_help#enable()
" }}}

" hook_post_update {{{
" call ddc#set_static_import_path()
" }}}
