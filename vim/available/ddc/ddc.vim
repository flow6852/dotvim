" hook_add {{{
for file in sort(['25-vsnip.vim', '40-ddc-global.vim', '41-ddc-skkeleton.vim', '42-ddc-cmdline.vim', '43-ddc-patch_filetype.vim', '60-textlint.vim', '90-keymapping.vim'])
    execute 'source ' . glob($BASE_DIR . "/available/ddc/" . file)
endfor
 " }}}
