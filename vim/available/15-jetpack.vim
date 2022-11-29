" vim-jetpack
call jetpack#begin('~/.vim')
    Jetpack 'junegunn/fzf.vim' " needed for previews

    " for lsp server install
    Jetpack 'Shougo/ddc.vim'

    Jetpack 'vim-denops/denops.vim'
    " カーソル周辺の既出単語を補完するsource
    Jetpack 'Shougo/ddc-around'
    " ファイル名を補完するsource
    Jetpack 'LumaKernel/ddc-file'
    " 入力中の単語を補完の対象にするfilter
    Jetpack 'Shougo/ddc-matcher_head'
    " 補完候補を適切にソートするfilter
    Jetpack 'Shougo/ddc-sorter_rank'
    " 補完候補の重複を防ぐためのfilter
    Jetpack 'Shougo/ddc-converter_remove_overlap'
    " オムニ補完
    Jetpack 'Shougo/ddc-omni'

    if has('nvim')
        Jetpack 'williamboman/nvim-lsp-installer' " LSPInstaller
        Jetpack 'neovim/nvim-lspconfig' " neovim's lspconfig'
        Jetpack 'Shougo/ddc-nvim-lsp' " lsp completion
    else
        Jetpack 'prabirshrestha/vim-lsp' " vim lsp
        Jetpack 'mattn/vim-lsp-settings' " vim-lsp auto setting
        Jetpack 'shun/ddc-vim-lsp' " ddc for vim-lsp
    endif          

    Jetpack 'lervag/vimtex'   
    " markdown preview without browser
    Jetpack 'skanehira/preview-markdown.vim'
    let g:preview_markdown_auto_update = "1"
    let g:preview_markdown_parser = "mdr"
                   
    " language     
    Jetpack 'rust-lang/rust.vim'
    Jetpack 'LumaKernel/coqpit.vim'
    Jetpack 'qnighy/satysfi.vim'
    
    " neosnipet 
    Jetpack 'Shougo/neosnippet.vim'
    Jetpack 'Shougo/neosnippet-snippets'
    
    " unite
    Jetpack 'Shougo/Unite.vim'
    " NERDTree
    " Jetpack 'preservim/nerdtree'

    " lexiv
    Jetpack 'mattn/vim-lexiv'
   
    " user
    " Jetpack '~/.vim/jetpackged/asvim'
    " Jetpack '~/.vim/jetpackged/inptest'
    " Jetpack '~/.vim/jetpackged/vim-auto-save'
    " Jetpack '~/.vim/jetpackged/myvimfuncs'
call jetpack#end()
