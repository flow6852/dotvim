" https://github.com/Shougo/ddc-nvim-lsp
let g:sources = insert(g:sources,'nvim-lsp', 0)

call ddc#custom#patch_global('sources', sources)
call ddc#custom#patch_global('sourceOptions',  { 
            \ 'nvim-lsp': {
            \   'mark': '[lsp]',
            \   'forceCompletionPattern': '\.\w*|:\w*|->\w*' 
            \   }
            \ })

" Use Customized labels
call ddc#custom#patch_global('sourceParams', {
      \ 'nvim-lsp': { 'kindLabels': { 'Class': '[Class]' } },
      \ })
