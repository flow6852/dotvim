let sources = insert(sources, 'neosnippet', 0)
call ddc#custom#patch_global('sources', sources)
call ddc#custom#patch_global('sourceOptions', {
      \ 'neosnippet': {'dup': v:true, 'mark': '[neosnippt]'},
      \ })
