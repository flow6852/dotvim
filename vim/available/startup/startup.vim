" hook_add {{{
for file in sort(['00-prefuncs.vim', '02-global_vars.vim', "03-filetype.vim", '91-autocmd.vim'])
    execute 'source ' . glob($BASE_DIR . "/available/startup/" . file)
endfor
 " }}}
