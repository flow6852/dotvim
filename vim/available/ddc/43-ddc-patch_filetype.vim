call ddc#custom#patch_filetype(['java'], 'keywordPattern', '[a-zA-Z_@\\\{\}*<>]*')
"" " Example: Use vimtex

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
" \ 'keywordPattern' : '[a-zA-Z_@\\\{\}*]*',
