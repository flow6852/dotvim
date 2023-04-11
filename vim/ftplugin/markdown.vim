setl tabstop=4
setl shiftwidth=4

augroup myMdBuild
    autocmd BufWritePost *.md call taskrunner#run({'cmdstr': "pandoc " . expand('%') . " --defaults /home/flow_6852/Templates/mytmp/pandoc/article.yml -o " . expand('%:r') . '.pdf'})
augroup END
