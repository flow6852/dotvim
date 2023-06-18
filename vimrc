" if exists('vim_startup')
"     finish
" endif
" 
" let vim_startup = ''
" set up the dein.vim directory
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let $BASE_DIR = expand('~/.vim')

" automatic installation of dein.vim
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim ' s:dein_repo_dir
endif
execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
exec "source " . $BASE_DIR . "/available/startup/startup.vim"

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " load the file which contain the plugin list
  let s:toml      = $BASE_DIR . '/available/dein.toml'
  let s:toml_lazy  = $BASE_DIR . '/available/dein_lazy.toml'
  let s:neovim_toml = $BASE_DIR . '/available/neovim.toml'
  let s:denops_toml = $BASE_DIR . '/available/denops_lazy.toml'
  let s:ddc_toml = $BASE_DIR . '/available/ddc/ddc_lazy.toml'
  let s:ddu_toml = $BASE_DIR . '/available/ddu/ddu_lazy.toml'

  call dein#load_toml(s:toml, {'lazy': v:false})
  call dein#load_toml(s:toml_lazy, {'lazy': v:true})
  call dein#load_toml(s:denops_toml, {'lazy': v:true})
  call dein#load_toml(s:ddc_toml, {'lazy': v:true})
  call dein#load_toml(s:ddu_toml, {'lazy': v:true})

  if has('nvim')
      call dein#load_toml(s:neovim_toml, {'lazy': v:true})
  else 

  endif

  call dein#end()
  call dein#save_state()
endif

" automatically install any plug-ins that need to be installed.
if dein#check_install()
  call dein#install()
endif

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

" popup color
hi Pmenu ctermbg=black ctermfg=white
hi PmenuSel ctermbg=yellow ctermfg=black
hi PmenuSbar ctermbg=black
hi PmenuThumb ctermfg=gray
