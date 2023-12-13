" hook_source {{{
" vimtex vals
" let g:vimtex_view_method = 'mupdf'
if Global_is_plugged('vimtex')
    let g:vimtex_compiler_latexmk_engines = { '_' : '-lualatex' }
    let g:vimtex_view_general_viewer = 'zathura'
    let g:vimtex_view_general_options = "-x \"nvr +%{line} %{input}\" --synctex-forward @line:0:@tex @pdf"
    let g:vimtex_quickfix_mode = 0
    " let g:tex_flavor = 'latex'
endif

let g:sources = insert(g:sources, 'omni', 2)

if(&filetype == 'tex')
    call ddc#custom#patch_filetype(['tex'], 'sources', g:sources)
    call ddc#custom#patch_filetype(['tex'], 'sourceOptions', {
          \ 'omni': {
          \   'forceCompletionPattern': g:vimtex#re#deoplete,
          \ 'mark' : '[vimtex]',
          \ },
          \ })
    call ddc#custom#patch_filetype(['tex'], 'sourceParams', {
          \ 'omni': {'omnifunc': 'vimtex#complete#omnifunc'},
          \ })
endif
" Use Customized labels
" \ 'keywordPattern' : '[a-zA-Z_@\\\{\}*]*',
" }}}
