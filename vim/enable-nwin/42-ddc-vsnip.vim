let g:sources = insert(g:sources, 'vsnip',0)
call ddc#custom#patch_global('sources',g:sources)
call ddc#custom#patch_global('sourceOptions', {
            \ 'vsnip' : {'mark': '[vsnip]',
            \            'dup': v:false}
            \})
call ddc#custom#patch_filetype( ['tex'],{
         \ 'smartCase' : v:true,
         \ })
autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)
         " \ 'keywordPattern' : '[a-zA-Z_@\\\{\}*]*', 
