"  Customize global settings
" Use around source.
" https://github.com/Shougo/ddc-around
let g:sources = ['around', 'file', 'path']
let autoCompleteEvents = ['InsertEnter', 'TextChangedI', 'TextChangedP']
let g:ui = 'pum'

call ddc#custom#patch_global('ui', ui) 
call ddc#custom#patch_global('autoCompleteEvents', autoCompleteEvents) 

call ddc#custom#patch_global('sources', sources)
" Use matcher_head and sorter_rank.
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
" https://github.com/tani/ddc-fuzzy
" Global Option
call ddc#custom#patch_global('sourceOptions', {
      \ '_': { 'matchers': ['matcher_fuzzy'],
      \        'sorters': ['sorter_fuzzy'],
      \        'converters': ['converter_fuzzy']
      \ },
      \ 'around': {'mark': '[around]'},
      \ 'file': {'mark': '[file]'},
      \ 'path': {'mark': '[path]'}
      \ })

call ddc#custom#patch_global('sourceParams', {
      \ 'around': {'maxSize': 500},
      \ })

call ddc#custom#patch_global('filterParams', {
  \   'converter_fuzzy': {
  \     'hlGroup': 'SpellBad'
  \   }
  \ })

" Use ddc.
call ddc#enable()

" Use popup preview
call popup_preview#enable()
call signature_help#enable()
