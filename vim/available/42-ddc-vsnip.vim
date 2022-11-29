let g:sources = insert(sources, "vsnip",1)
call ddc#custom#patch_global('sources', sources)
call ddc#custom#patch_global('sourceOptions', {
            \ 'vsnip' : {'mark': '[vsnip]',
            \            'dup': v:true
            \           }
            \})
call ddc#custom#patch_filetype( ['tex'],{
        \ 'smartCase' : v:true
        \ })
autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)
"         \ 'keywordPattern' : '[a-zA-Z_@\\\{\}*]*',
