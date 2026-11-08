" check the specified plugin is installed
function Global_is_plugged(name)
    if match(&runtimepath, a:name) >= 0
        return 1
    else
        return 0
    endif
endfunction

set nocompatible

au QuickfixCmdPost make,grep,vimgrep,grepadd copen

" default
set title
set number
set clipboard=unnamedplus
syntax enable
set expandtab
set tabstop=4
set shiftwidth=4
set foldmethod=indent
set completeopt=menuone,noinsert
set encoding=utf-8
set hidden
set updatetime=300
set shortmess+=c

filetype plugin indent on

if has('nvim')
    " set cmdheight=0
    set laststatus=0
else
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
    set noshowmode
endif

" popup color
hi Pmenu ctermbg=black ctermfg=white
hi PmenuSel ctermbg=yellow ctermfg=black
hi PmenuSbar ctermbg=black
hi PmenuThumb ctermfg=gray

" background color
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE
highlight Folded ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE

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

autocmd WinLeave * if (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | cclose | endif
