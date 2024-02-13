if !exists('g:l_myFormatters')
        autocmd QuitPre * call myformatter#markdown()

        " command! -nargs=* QuitWrapper call myformattrer#markdownFormatter(<f-args>)
endif
let g:l_myFormatters = 1
