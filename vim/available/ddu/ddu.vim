" hook_add {{{
for file in sort(['50-ddu-patch_local.vim', '51-ddu-start.vim', '52-ddu-custom-action.vim', '53-ddu-filetype_mapping.vim'])
    execute 'source ' . glob($BASE_DIR . "/available/ddu/" . file)
endfor
 " }}}
