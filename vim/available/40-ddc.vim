"  Customize global settings
" Use around source.
" https://github.com/Shougo/ddc-around
let g:sources = ['around', 'rg', 'buffer', 'file', 'input']
let autoCompleteEvents = ['InsertEnter', 'TextChangedI', 'TextChangedP']
let g:ui = 'pum'
call pum#set_option('auto_select', v:false)

call ddc#custom#patch_global('ui', ui) 
call pum#set_option('auto_select', v:false)
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
      \         
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
