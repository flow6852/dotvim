if exists("vim_starting")
    finish
endif

let vim_starting = ''

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

filetype plugin on

" install enable
" source <sfile>:h/.vim/enable/vim-plug.vim
if has('nvim')
    for f in split(glob(expand("<sfile>:p:h") . "/.vim/enable-nvim/*.vim"), "\n")
        execute 'source' f
    endfor
    set cmdheight=0
else
    for f in split(glob(expand("<sfile>:p:h") . "/.vim/enable-vim/*.vim"), "\n")
        execute 'source' f
    endfor
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

if(has("nvim"))
    augroup termloop
        autocmd!
        autocmd ExitPre * call TermLoop()
    augroup End
    
    function! TermLoop(...)
        if len(getwininfo()) == 1 && getwininfo()[0]['terminal'] == 0
            let s:listed_buffer = getbufinfo({'buflisted': 1})[0]['bufnr']
            execute getbufinfo({'buflisted': 1})[0]['bufnr'] . 'buffer'
            vsplit
        endif
    endfunction
endif
