setl tabstop=4
setl shiftwidth=4

augroup myMdBuild
    autocmd BufWritePost *.md if findfile("defaults.yml") | call taskrunner#run({'cmdstr': "pandoc " . expand('%') . " --defaults defaults.yml -o " . expand('%:r') . '.pdf'}) | endif
augroup END
