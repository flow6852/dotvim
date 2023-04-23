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

let g:enableConfigFiles = [
    \ "00-prefuncs.vim", "01-terminal.vim",
    \ "11-global-vars.vim",
    \ "25-vsnip.vim",
    \ "40-ddc-global.vim", "41-ddc-skkeleton.vim", "42-ddc-cmdline.vim", "43-ddc-patch_filetype.vim",
    \ "50-ddu-patch_local.vim", "51-ddu-start.vim", "52-ddu-filetype_mapping.vim",
    \ "90-keymapping.vim", "91-autocmd.vim"]

" install enable
" source <sfile>:h/.vim/enable/vim-plug.vim

if has('unix')
    let g:enableConfigFiles = extend(g:enableConfigFiles,
            \ has('nvim') ? ["10-vim-plug-unix.vim", "25-vsnip.vim", "30-vimtex.vim", "60-textlint.vim"]:
                          \ ["10-vim-plug-unix.vim", "25-vsnip.vim", "60-textlint.vim"])
else
    let g:enableConfigFiles = extend(g:enableConfigFiles, ["10-vim-plug-win.vim"])
endif

if has('nvim')
    set cmdheight=0
else
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
    set noshowmode
endif

for file in sort(g:enableConfigFiles)
    execute 'source' glob(expand("<sfile>:p:h") . "/.vim/available/" . file)
    " echom  glob(expand("<sfile>:p:h") . "/.vim/available/" . file)
endfor

" popup color
hi Pmenu ctermbg=black ctermfg=white
hi PmenuSel ctermbg=yellow ctermfg=black
hi PmenuSbar ctermbg=black
hi PmenuThumb ctermfg=gray
