" hook_source {{{
" for file in sort(['ddc-global.vim', 'vsnip.vim',  'ddc-skkeleton.vim', 'ddc-patch_filetype.vim', 'textlint.vim', 'keymapping.vim'])
"     execute 'source ' . glob($BASE_DIR . "/available/ddc/" . file)
" endfor
" 
" execute 'source ' . glob($BASE_DIR . "/available/ddc/" . "ddc-cmdline.vim")
" }}}
"
" hook_post_update {{{
call ddc#set_static_import_path()
" }}}
