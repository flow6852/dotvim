" " Example: Use vimtex
call vimtex#init()
let g:sources = insert(sources, "omni", 0)
call ddc#custom#patch_global('sources', sources)
call ddc#custom#patch_filetype(['tex'], 'sourceOptions', {
      \ 'omni': {
      \   'forceCompletionPattern': g:vimtex#re#deoplete,
      \ 'mark' : '[vimtex]',
      \ },
      \ })
call ddc#custom#patch_filetype(['tex'], 'sourceParams', {
      \ 'omni': {'omnifunc': 'vimtex#complete#omnifunc'},
      \ })
" Use Customized labels
call ddc#custom#patch_global('sourceParams', {
      \ 'nvim-lsp': { 'kindLabels': { 'Class': '[Class]' } },
      \ })
