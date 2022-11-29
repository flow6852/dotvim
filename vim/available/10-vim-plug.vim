" vim-plug
call plug#begin('~/.vim/plugged')
    " vimのhelpの日本語化
    Plug 'vim-jp/vimdoc-ja'
    " markdown preview without browser
    Plug 'skanehira/preview-markdown.vim'
    let g:preview_markdown_auto_update = "1"
    let g:preview_markdown_parser = "mdr"
                   
    " language     
    Plug 'rust-lang/rust.vim'
    Plug 'LumaKernel/coqpit.vim'
    Plug 'qnighy/satysfi.vim'

    Plug 'junegunn/fzf.vim' " needed for previews

    " for lsp server install
    Plug 'Shougo/ddc.vim'
    " custom popup window
    Plug 'Shougo/pum.vim'

    Plug 'vim-denops/denops.vim'
    " カーソル周辺の既出単語を補完するsource
    Plug 'Shougo/ddc-source-around'
    " ファイル名を補完するsource
    Plug 'LumaKernel/ddc-file'
    " パス補完
    Plug 'tani/ddc-path'
    " コマンドライン補完
    Plug 'Shougo/ddc-source-cmdline'
    " historyを使ったコマンドライン補完
    Plug 'Shougo/ddc-source-cmdline-history'
    " fuzzy-finderを使った周辺検索，ソート，重複をするfilter
    Plug 'tani/ddc-fuzzy'
    " オムニ補完
    Plug 'Shougo/ddc-omni'
    " UI
    Plug 'Shougo/ddc-ui-native'
    Plug 'Shougo/ddc-ui-pum'

    if has('nvim')
        Plug 'williamboman/mason.nvim' " LSPInstaller
        Plug 'williamboman/mason-lspconfig.nvim' " LSPInstaller
        " Plug 'williamboman/nvim-lsp-installer'
        Plug 'neovim/nvim-lspconfig' " neovim's lspconfig'
        Plug 'Shougo/ddc-source-nvim-lsp' " lsp completion
    else
        Plug 'prabirshrestha/vim-lsp' " vim lsp
        Plug 'mattn/vim-lsp-settings' " vim-lsp auto setting
        Plug 'shun/ddc-source-vim-lsp' " ddc for vim-lsp
    endif          

    Plug 'matsui54/denops-popup-preview.vim' " popup preview
    Plug 'matsui54/denops-signature_help' " restrict preview popup preview

    Plug 'lervag/vimtex' 
    """" snippet
    Plug  'hrsh7th/vim-vsnip'
    Plug  'hrsh7th/vim-vsnip-integ'
    " snippet sets
    " Plug 'rafamadriz/friendly-snippets'
   
    " neosnipet 
    " Plug 'Shougo/neosnippet.vim'
    " Plug 'Shougo/neosnippet-snippets'
    " 
    " deoppet
    " Plug 'Shougo/deoppet.nvim'
    
    """" UI framework
    Plug 'Shougo/ddu.vim'

    " fuzzy finder UI
    Plug 'Shougo/ddu-ui-ff'

    " filter matcher substring
    Plug 'Shougo/ddu-filter-matcher_substring'

call plug#end()
