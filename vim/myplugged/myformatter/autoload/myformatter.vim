function! myformatter#markdown(a:file)
    execute("!deno fmt " . a:file)
    execute("e " . a:file)
    execute("%s/\\\\$/  /g")
endfunction
