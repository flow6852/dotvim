call pum#set_option('auto_select', v:false)
let autoCompleteEvents = ['InsertEnter', 'TextChangedI', 'TextChangedP']
let g:sources = ['vsnip', 'around', 'buffer', 'file', 'input']
let g:sourceOptions = {
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
      \ 'vsnip' : {'mark': '[vsnip]',
      \            'dup': v:false}
      \ }

let g:sourceParams = {
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
      \ }

if executable('rg') 
    let g:sources = add(g:sources, 'rg')
    let g:sourceOptions = extend(g:sourceOptions, {'rg': { 'mark': '[ripgrep]' }})
endif

if Global_is_plugged('ddc-nvim-lsp') && has('nvim')
    " https://github.com/Shougo/ddc-nvim-lsp
    let g:sources = insert(g:sources,'nvim-lsp', 0)
    let g:sourceOptions = extend(g:sourceOptions, {'nvim-lsp': {'mark': '[lsp]', 'forceCompletionPattern': '\.\w*|:\w*|->\w*'}})
    let g:sourceParams = extend(g:sourceParams, {'nvim-lsp': {'kindLabels': {'Class': '[Class]'}}})
elseif Global_is_plugged('ddc-vim-lsp')
    let sources = add(sources, 'vim-lsp')
    let g:sourceOptions = extend(g:sourceOptions, {'vim-lsp': {'mark': 'lsp',}})
endif

call ddc#custom#patch_global('sources', g:sources)
call ddc#custom#patch_global('backspaceCompletion', v:true)
call ddc#custom#patch_global('sourceOptions', g:sourceOptions)
call ddc#custom#patch_global('autoCompleteEvents', autoCompleteEvents)
call ddc#custom#patch_global('ui', g:ui)
call ddc#custom#patch_global('sourceParams', g:sourceParams)
call ddc#custom#patch_global('filterParams', {
  \   'converter_fuzzy': {
  \     'hlGroup': 'SpellBad'
  \   },
  \   'matcher_editdistance': {'showScore': v:true, 'diffLen': 0, 'limit': 100},
  \ })



autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)
         

call ddc#enable()
call popup_preview#enable()
call signature_help#enable()
