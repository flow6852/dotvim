function ForDduSourceOptionsPath(...)
    if isdirectory(expand(expand("<cfile>")))
        return expand("<cfile>")
    else
        return trim(expand(execute("pwd")))
    endif
endfunction

" ddu-option
call ddu#custom#patch_local('filer', Ddu_custom_cfg('floating', 'vertical', v:true))

nmap <silent> ;b <Cmd>call DduOpenWithPreview('filer', [{'name': 'buffer'}])<CR>
nmap <silent> ;f <Cmd>call DduOpenWithPreview('filer', [{'name': 'file_rec', 'params': {'expandSymbolicLink': v:true}}])<CR>
