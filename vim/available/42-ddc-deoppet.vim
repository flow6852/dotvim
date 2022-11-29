let sources = add(sources, 'deoppet')
call deoppet#initialize()
call deoppet#custom#option('snippets',
\ map(globpath(&runtimepath, 'neosnippets', 1, 1),
\     { _, val -> { 'path': val } }))

imap <C-k>  <Plug>(deoppet_expand)
imap <C-f>  <Plug>(deoppet_jump_forward)
imap <C-b>  <Plug>(deoppet_jump_backward)
smap <C-f>  <Plug>(deoppet_jump_forward)
smap <C-b>  <Plug>(deoppet_jump_backward)

" Use deoppet source.
call ddc#custom#patch_global('sources', sources)

" Change source options
call ddc#custom#patch_global('sourceOptions', {
      \ 'deoppet': {'dup': v:true, 'mark': 'dp'},
      \ })
