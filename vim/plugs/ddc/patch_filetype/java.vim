" hook_source {{{
let g:sources = insert(g:sources, 'omni', 2)

call ddc#custom#patch_filetype(['java'], 'keywordPattern', '[a-zA-Z_@\\\{\}*<>]*')
" }}}
