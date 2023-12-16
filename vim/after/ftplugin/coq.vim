function! MyCoqMaps()
	nnoremap <silent> <C-C>        :CoqLaunch<CR>
	nnoremap <silent> <Leader>j    :CoqNext<CR>
	nnoremap <silent> <Leader>k    :CoqBack<CR>
	nnoremap <silent> <Leader>l    :CoqToCursor<CR>
	nnoremap <silent> <Leader>G    :CoqToLast<CR>
	nnoremap <silent> <Leader>g    :CoqRerun<CR>
	nnoremap <silent> <Leader>t    :MoveToTop<CR>
	nnoremap <silent> <Leader><F5> :CoqRefresh<CR>
	
	nnoremap <Leader>compute :CoqQuery Compute .<Left>
	nnoremap <Leader>print :CoqQuery Print .<Left>
	nnoremap <Leader>check :CoqQuery Check .<Left>
	nnoremap <Leader>se :CoqQuery Search ().<Left><Left>
endfunction

augroup my_coq
	au!
	au FileType coq :call MyCoqMaps()
augroup END
