function! satysfi#compile(...)
        let cmd = "satysfi " . g:satyFilename . " -o " . g:satyPdfname . "; echo $status"
        let syslisttmp = systemlist(cmd)
        let status = syslisttmp[-1]
        let syslist = syslisttmp[0:-2]
        let nr = winnr()
        if status == "0"
                cclose
                if str2nr(system("ps aux | grep \"evince " . g:satyPdfname . "\" | wc -l")) < 3 
                        exec system("evince " . g:satyPdfname . " &")
                end
        else
                copen
	        call setqflist([], " ", {'nr':'$', 'lines': syslist})
                wincmd k
        end
        exec win_gotoid(nr)
endfunction

function! satysfi#quit()
        killall evince
endfunction

