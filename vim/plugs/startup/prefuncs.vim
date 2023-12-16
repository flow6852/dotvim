" https://ryochack.hatenablog.com/entry/2018/04/08/162354
" for vim-plug
" check the specified plugin is installed
function Global_is_plugged(name)
    if match(&runtimepath, a:name) >= 0
        return 1
    else
        return 0
    endif
endfunction
