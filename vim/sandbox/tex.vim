if exists('g:l_tex_vim')
  finish
endif
let g:l_tex_vim = 1

command! -nargs=* Exetext call Exetext()

autocmd BufWritePost * call Comp()
autocmd QuitPre * cclose

function! Comp()
	if expand("%:e") != "tex"
		return	
	endif
	let raw = systemlist("mkpdf.sh " . expand("%") . "; echo $?")
	if str2nr(raw[len(raw)-1]) == 0
		cclose
		echo "done."
	else
		copen
		call setqflist([], " ", {'nr':'$', 'lines': raw[:len(raw)-2]})
		wincmd k
	endif
endfunction

function! Exetext()
	if expand("%:e") != "tex"
		return
	endif
	if getftype("Makefile") != ""
		let fname = systemlist("pwd | awk '{sub(\".*/\", \"\"); print $0};'")
		call system("ps aux | grep mupdf\\ $(pwd)/" . fname[0] . ".pdf | grep -v grep | awk '{print $2}' | xargs kill -9")
		call system("i3-msg \"workspace 2; exec mupdf $(pwd)/" . fname[0] . ".pdf > /dev/null 2>&1 &\"")
	else
		call system("ps aux | grep mupdf\\ $(pwd)/" . expand("%:r") . ".pdf | grep -v grep | awk '{print $2}' | xargs kill -9")
		call system("i3-msg \"workspace 2; exec mupdf $(pwd)/" . expand("%:r") . ".pdf > /dev/null 2>&1 &\"")
	endif
endfunction

" command Exetest :! ps aux | grep mupdf\ %:r.pdf | grep -v grep | awk '{print $2}' | xargs kill -9; mupdf %:r.pdf > /dev/null 2>&1 &
