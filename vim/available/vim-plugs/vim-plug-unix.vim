" vim-plug
call plug#begin('~/.vim/plugged')
    " vimのhelpの日本語化
    Plug 'vim-jp/vimdoc-ja'
    " 日本語入力
    Plug 'vim-skk/skkeleton'
    Plug 'thinca/vim-scouter'

    " needed for previes
    Plug 'junegunn/fzf.vim'

    """""""""""""""""""""""""""""
    "                           "
    "          denops           "
    "                           "
    """""""""""""""""""""""""""""
    Plug 'vim-denops/denops.vim'
    Plug 'flow6852/dps-mergeqf'
    Plug 'flow6852/dps-taskrunner'

    """""""""""""""""""""""""
    "                       "
    "          LSP          "
    "                       "
    """""""""""""""""""""""""
    Plug 'rust-lang/rust.vim'
    Plug 'LumaKernel/coqpit.vim'
    Plug 'qnighy/satysfi.vim'
    if len(split(system('which latexmk'))) < 2
            " for tex
        Plug 'lervag/vimtex'
    endif

    if has('nvim')
        " LSPInstaller
        Plug 'williamboman/mason.nvim'
        " LSPInstaller
        Plug 'williamboman/mason-lspconfig.nvim'
        " neovim's lspconfig'
        Plug 'neovim/nvim-lspconfig'
        " lsp completion
        Plug 'Shougo/ddc-nvim-lsp'
    else
        " vim lsp
        Plug 'prabirshrestha/vim-lsp'
        " vim-lsp auto setting
        Plug 'mattn/vim-lsp-settings'
        " ddc for vim-lsp
        Plug 'shun/ddc-vim-lsp'
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
    " カーソル周辺の既出単語を補完するsource
    Plug 'Shougo/ddc-source-around'
    " ファイル名を補完するsource
    Plug 'LumaKernel/ddc-source-file'
    " パス補完
    Plug 'tani/ddc-path'
    " バッファから
    Plug 'matsui54/ddc-buffer' 
    " コマンドライン補完
    Plug 'Shougo/ddc-source-cmdline'
    " historyを使ったコマンドライン補完
    Plug 'Shougo/ddc-source-cmdline-history'
    " オムニ補完
    Plug 'Shougo/ddc-source-omni'
    " ライン
    Plug 'Shougo/ddc-source-line'
    " input()
    Plug 'Shougo/ddc-source-input'
    " ripgrep補完
    Plug 'Shougo/ddc-source-rg'

    " popup preview
    Plug 'matsui54/denops-popup-preview.vim'
    " restrict preview popup preview
    Plug 'matsui54/denops-signature_help' 

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
    " fuzzy-finderを使った周辺検索，ソート，重複をするfilter
    Plug 'tani/ddc-fuzzy' 
    " 編集距離を使ったfilter
    Plug 'matsui54/ddc-filter_editdistance'
    " 重複文字列を削除して置換
    Plug 'Shougo/ddc-converter_remove_overlap'
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
    " fuzzy finder UI
    Plug 'Shougo/ddu-ui-ff'
    " filer UI
    Plug 'Shougo/ddu-ui-filer'

    """"""""""""""""""""""""""""
    "         ddu source       "
    """"""""""""""""""""""""""""
    Plug 'Shougo/ddu-source-file'
    " Plug 'flow6852/ddu-source-file_rec'
    Plug 'Shougo/ddu-source-file_rec'
    " Plug 'flow6852/ddu-source-file_rec'
    Plug 'Shougo/ddu-source-buffer'
    Plug 'Shougo/ddu-source-rg'
    Plug 'Shougo/ddu-source-line'
    Plug 'matsui54/ddu-source-help'
    Plug 'Shougo/ddu-source-register'
    Plug 'mikanIchinose/ddu-source-markdown'
    Plug 'liquidz/ddu-source-custom-list'
    Plug 'flow6852/ddu-source-qf'
    Plug 'flow6852/ddu-source-url'
    Plug 'kamecha/ddu-source-window'
    Plug 'flow6852/ddu-source-vim_variable'
    Plug 'flow6852/ddu-source-vim_option'
    Plug 'flow6852/ddu-source-vim_function'
    Plug 'flow6852/ddu-source-vim_event'
    Plug 'flow6852/ddu-source-vim_command'
    Plug 'kyoh86/ddu-source-quickfix_history'

    """"""""""""""""""""""""""""
    "         ddu filter       "
    """"""""""""""""""""""""""""
    Plug 'Shougo/ddu-filter-matcher_substring'
    Plug 'Shougo/ddu-filter-matcher_relative'
    Plug 'Shougo/ddu-filter-converter_display_word'
    Plug 'yuki-yano/ddu-filter-fzf'
    Plug 'matsui54/ddu-filter-fzy'


    """"""""""""""""""""""""""""
    "         ddu kind         "
    """"""""""""""""""""""""""""
    Plug 'Shougo/ddu-kind-file'
    Plug '4513ECHO/ddu-kind-url'
    Plug 'flow6852/ddu-kind-vim_type'
    Plug 'Shougo/ddu-column-filename'

    " for atcoder
    Plug 'flow6852/dps-atcoder-facilitator'

    Plug 'kat0h/bufpreview.vim'
    Plug 'thinca/vim-showtime'
call plug#end()
