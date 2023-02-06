" vim-plug
call plug#begin('~/.vim/plugged')
    Plug 'vim-jp/vimdoc-ja' " vimのhelpの日本語化
    Plug 'vim-skk/skkeleton' " 日本語入力
    Plug 'thinca/vim-scouter'

    Plug 'skanehira/preview-markdown.vim' " markdown preview without browser
    let g:preview_markdown_auto_update = "1"
    let g:preview_markdown_parser = "mdr"
         
    Plug 'junegunn/fzf.vim' " needed for previews
    Plug 'vim-denops/denops.vim'          

    """""""""""""""""""""""""
    "                       "
    "          LSP          "
    "                       "
    """""""""""""""""""""""""
    Plug 'rust-lang/rust.vim'
    Plug 'LumaKernel/coqpit.vim'
    Plug 'qnighy/satysfi.vim'
    Plug 'lervag/vimtex' " for tex
    if has('nvim')
        Plug 'williamboman/mason.nvim' " LSPInstaller
        Plug 'williamboman/mason-lspconfig.nvim' " LSPInstaller
        " Plug 'williamboman/nvim-lsp-installer'
        Plug 'neovim/nvim-lspconfig' " neovim's lspconfig'
        Plug 'Shougo/ddc-nvim-lsp' " lsp completion
    else
        Plug 'prabirshrestha/vim-lsp' " vim lsp
        Plug 'mattn/vim-lsp-settings' " vim-lsp auto setting
        Plug 'shun/ddc-vim-lsp' " ddc for vim-lsp
    endif

    """"""""""""""""""""""""""""
    "                          "
    "      ddc (completion)    "
    "                          " 
    """"""""""""""""""""""""""""
    " for lsp server install
    Plug 'Shougo/ddc.vim'
    " custom popup window
    Plug 'Shougo/pum.vim'

    """"""""""""""""""""""""""""
    "       ddc sources        "
    """"""""""""""""""""""""""""
    Plug 'Shougo/ddc-source-around' " カーソル周辺の既出単語を補完するsource
    Plug 'LumaKernel/ddc-source-file' " ファイル名を補完するsource
    Plug 'tani/ddc-path' " パス補完
    Plug 'matsui54/ddc-buffer' "バッファから
    Plug 'Shougo/ddc-source-cmdline' " コマンドライン補完
    Plug 'Shougo/ddc-source-cmdline-history' " historyを使ったコマンドライン補完
    Plug 'Shougo/ddc-source-omni' " オムニ補完
    Plug 'Shougo/ddc-source-line' "ライン
    Plug 'Shougo/ddc-source-input' "input()
    Plug 'Shougo/ddc-source-rg' "ripgrep補完

    Plug 'matsui54/denops-popup-preview.vim' " popup preview
    Plug 'matsui54/denops-signature_help' " restrict preview popup preview

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

    """"""""""""""""""""""""""""
    "       ddc ui             "
    """"""""""""""""""""""""""""
    Plug 'Shougo/ddc-ui-native'
    Plug 'Shougo/ddc-ui-pum'

    """"""""""""""""""""""""""""
    "       ddc filter         "
    """"""""""""""""""""""""""""
    Plug 'tani/ddc-fuzzy' " fuzzy-finderを使った周辺検索，ソート，重複をするfilter
    Plug 'matsui54/ddc-filter_editdistance' " 編集距離を使ったfilter
    Plug 'Shougo/ddc-converter_remove_overlap' " 重複文字列を削除して置換
    Plug 'Shougo/ddc-sorter_rank'
    Plug 'Shougo/ddc-matcher_head'

    """"""""""""""""""""""""""""
    "                          "
    "         ddu (ui)         "
    "                          " 
    """"""""""""""""""""""""""""
    
    Plug 'Shougo/ddu.vim'

    """"""""""""""""""""""""""""
    "         ddu  ui          "
    """"""""""""""""""""""""""""
    Plug 'Shougo/ddu-ui-ff' " fuzzy finder UI
    Plug 'Shougo/ddu-ui-filer' " filer UI

    """"""""""""""""""""""""""""
    "         ddu source       "
    """"""""""""""""""""""""""""
    Plug 'Shougo/ddu-source-file'
    " Plug '~/Programs/ddu-source-file_rec'
    Plug 'Shougo/ddu-source-file_rec'
    " Plug 'flow6852/ddu-source-file_rec'
    Plug 'Shougo/ddu-source-buffer'
    Plug 'Shougo/ddu-source-rg'
    Plug 'Shougo/ddu-source-line'
    Plug 'matsui54/ddu-source-help'
    Plug 'Shougo/ddu-source-register'
    Plug 'mikanIchinose/ddu-source-markdown'
    Plug 'liquidz/ddu-source-custom-list'
    Plug 'flow6852/dps-mergeqf'
    Plug 'flow6852/ddu-source-qf'
    " Plug '~/Programs/dps-mergeqf'
    " Plug '~/Programs/ddu-source-qf'

    """"""""""""""""""""""""""""
    "         ddu filter       "
    """"""""""""""""""""""""""""
    Plug 'Shougo/ddu-filter-matcher_substring'
    Plug 'Shougo/ddu-filter-matcher_relative'
    Plug 'Shougo/ddu-filter-converter_display_word'
    Plug 'yuki-yano/ddu-filter-fzf'


    """"""""""""""""""""""""""""
    "         ddu kind         "
    """"""""""""""""""""""""""""
    Plug 'Shougo/ddu-kind-file'
    Plug 'Shougo/ddu-column-filename'

    " user
    Plug '~/.vim/plugged/asvim'
    Plug '~/.vim/plugged/inptest'
    Plug '~/.vim/plugged/vim-auto-save'
call plug#end()
