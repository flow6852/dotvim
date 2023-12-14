if !exists('g:l_myfuncs')
        autocmd QuitPre * call myvimfuncs#QuitWrapper()
"         autocmd WinEnter * call myvimfuncs#ResizedWrapper()
"         autocmd WinLeave * call myvimfuncs#ResizedWrapper()
"         autocmd WinNew * call myvimfuncs#ResizedWrapper()
        
        command! -nargs=* QuitWrapper call myvimfuncs#QuitWrapper(<f-args>)
endif
let g:l_myfuncs = 1


