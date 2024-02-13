function! myvimfuncs#QuitWrapper(...)
     let termorquicks = len(filter(getwininfo(),{ind, val -> val['terminal'] == 1 || val['quickfix'] == 1}))
     let nowins = winnr('$')
     let nowcurs = call("getbufvar", [bufnr("%"), "&buftype"]) != "terminal"
     if nowins - termorquicks == 1
         for item in reverse(filter(getwininfo(), {ind, val -> val['terminal'] == 1}))
             execute item['winnr'] . "quit!"
         endfor
         cclose
     endif
endfunction

" function! myvimfuncs#ResizedWrapper(...)
"         for item in filter(getwininfo(), {ind, val -> val['terminal']})
"                 execute item['winnr'] . "resize 10"
"         endfor
" endfunction
