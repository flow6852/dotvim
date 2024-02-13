function! formatter#markdown(file)
    let s:i = 1
    let s:cmd = "cat " . a:file . " | deno fmt --ext md -"
    for line in systemlist(s:cmd)
        call setline(s:i, line)
        let s:i = s:i + 1
    endfor
    call execute("%s/\\\\$/  /g", "silent!")
endfunction
