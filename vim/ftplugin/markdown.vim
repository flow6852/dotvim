setl tabstop=4
setl shiftwidth=4

nnoremap <silent> <Space>f <Cmd>call markdownUtil#formatter(expand("%:p"))<CR>
 
" if !exists('g:l_ftplugin_markdown')
" function! MarkdownFormatUsingDeno(file)
"     call execute("!deno fmt --quiet " . a:file, "silent!")
"     call execute("e " . a:file, "silent!!") 
"     call execute("%s/\\\\$/  /g", "silent!")
" endfunction
" endif
" 
" let g:l_ftplugin_markdown = 1
