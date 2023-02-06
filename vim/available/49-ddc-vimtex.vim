" " Example: Use vimtex
call vimtex#init()
let g:sources = insert(g:sources, 'omni', 2)
call ddc#custom#patch_filetype(['tex'], 'sources', g:sources)
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
