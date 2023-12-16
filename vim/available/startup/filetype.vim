augroup localfile 
     autocmd! 
     autocmd BufRead,BufNewFile *.md setfiletype markdown 
     autocmd BufRead,BufNewFile *.tex setfiletype tex 
     autocmd BufRead,BufNewFile *.c setfiletype c 
     autocmd BufRead,BufNewFile *.scala setfiletype scala 
     autocmd BufRead,BufNewFile *.v setfiletype coq 
     autocmd BufRead,BufNewFile *.sml setfiletype sml 
     autocmd BufRead,BufNewFile *.snip setfiletype neosnippet 
     autocmd BufRead,BufNewFile *.bib setfiletype bibtex 
     autocmd BufRead,BufNewFile *.vim setfiletype vim 
     autocmd BufRead,BufNewFile *.cob setfiletype cobol 
augroup End
