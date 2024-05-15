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

call popup_preview#enable()
call signature_help#enable()

" }}}

" hook_post_update {{{
" call ddc#set_static_import_path()
" }}}
