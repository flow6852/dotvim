let sources = add(sources, 'vim-lsp')

" source options
call ddc#custom#patch_global('sourceOptions', {
    \ 'vim-lsp': {
    \   'mark': 'lsp',
    \ },
    \ })
