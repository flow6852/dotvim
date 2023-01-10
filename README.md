# vim-neovim-test-env

vimやneovimのテスト環境です．

## Installation

```bash
$ ./cp_home_vim_dir.sh
# docker build -t . vim-test-env
```

## Usage

### vim9

```bash
# docker run --rm -it vim-neovim-test-env /bin/bash
[user] $ vim test.txt
```

### neovim

```bash
# docker run --rm -it vim-neovim-test-env /bin/bash
[user] $ nvim test.txt
```

## Config

`./cp_home_vim_dir.sh`の中身を変更してください．

* `Homedirs`は`${HOME}`下のドットファイルを`./cp_home_vim_dir.sh`と同じディレクトリにコピーします．
* `Vimdirs`は`${HOME}/.vim`下のファイルを`./cp_home_vim_dir.sh`と同じディレクトリの`vim`にコピーします．
* `Neovimdirs`は`${HOME}/config/nvim`下のファイルを`./cp_home_vim_dir.sh`と同じディレクトリにコピーします．

## Plugin

ここでは私が使わせていただいているPluginの例を挙げています．

### List

* https://github.com/vim-jp/vimdoc-ja " vimのhelpの日本語化
* https://github.com/vim-skk/skkeleton " 日本語入力
* https://github.com/thinca/vim-scouter
* https://github.com/skanehira/preview-markdown.vim " markdown preview without browser
* https://github.com/junegunn/fzf.vim " needed for previews
* https://github.com/vim-denops/denops.vim          
* https://github.com/rust-lang/rust.vim
* https://github.com/LumaKernel/coqpit.vim
* https://github.com/qnighy/satysfi.vim
* https://github.com/lervag/vimtex " for tex
* https://github.com/williamboman/mason.nvim " LSPInstaller
* https://github.com/williamboman/mason-lspconfig.nvim " LSPInstaller
* https://github.com/neovim/nvim-lspconfig " neovim's lspconfig'
* https://github.com/Shougo/ddc-nvim-lsp " lsp completion
* https://github.com/prabirshrestha/vim-lsp " vim lsp
* https://github.com/mattn/vim-lsp-settings " vim-lsp auto setting
* https://github.com/shun/ddc-vim-lsp " ddc for vim-lsp
* https://github.com/Shougo/ddc.vim
* https://github.com/Shougo/pum.vim
* https://github.com/Shougo/ddc-source-around " カーソル周辺の既出単語を補完するsource
* https://github.com/LumaKernel/ddc-source-file " ファイル名を補完するsource
* https://github.com/tani/ddc-path " パス補完
* https://github.com/matsui54/ddc-buffer "バッファから
* https://github.com/Shougo/ddc-source-cmdline " コマンドライン補完
* https://github.com/Shougo/ddc-source-cmdline-history " historyを使ったコマンドライン補完
* https://github.com/Shougo/ddc-source-omni " オムニ補完
* https://github.com/Shougo/ddc-source-line "ライン
* https://github.com/Shougo/ddc-source-input "input()
* https://github.com/Shougo/ddc-source-rg "ripgrep補完
* https://github.com/matsui54/denops-popup-preview.vim " popup preview
* https://github.com/matsui54/denops-signature_help " restrict preview popup preview
* https://github.com/hrsh7th/vim-vsnip
* https://github.com/hrsh7th/vim-vsnip-integ
* https://github.com/Shougo/ddc-ui-native
* https://github.com/Shougo/ddc-ui-pum
* https://github.com/tani/ddc-fuzzy " fuzzy-finderを使った周辺検索，ソート，重複をするfilter
* https://github.com/matsui54/ddc-filter_editdistance " 編集距離を使ったfilter
* https://github.com/Shougo/ddc-converter_remove_overlap " 重複文字列を削除して置換
* https://github.com/Shougo/ddc-sorter_rank
* https://github.com/Shougo/ddc-matcher_head
* https://github.com/Shougo/ddu.vim
* https://github.com/Shougo/ddu-ui-ff " fuzzy finder UI
* https://github.com/Shougo/ddu-ui-filer " filer UI
* https://github.com/Shougo/ddu-source-file
* https://github.com/Shougo/ddu-source-file_rec
* https://github.com/Shougo/ddu-source-buffer
* https://github.com/Shougo/ddu-source-rg
* https://github.com/Shougo/ddu-source-line
* https://github.com/matsui54/ddu-source-help
* https://github.com/Shougo/ddu-source-register
* https://github.com/mikanIchinose/ddu-source-markdown
* https://github.com/liquidz/ddu-source-custom-list
* https://github.com/Shougo/ddu-filter-matcher_substring
* https://github.com/Shougo/ddu-filter-matcher_relative
* https://github.com/Shougo/ddu-filter-converter_display_word
* https://github.com/yuki-yano/ddu-filter-fzf
* https://github.com/Shougo/ddu-kind-file
* https://github.com/Shougo/ddu-column-filename
* https://github.com/~/.vim/plugged/asvim
* https://github.com/~/.vim/plugged/inptest
* https://github.com/~/.vim/plugged/vim-auto-save
* https://github.com/~/.vim/plugged/myvimfuncs
