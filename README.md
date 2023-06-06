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

* https://github.com/vim-jp/vimdoc-ja
* https://github.com/vim-skk/skkeleton
* https://github.com/thinca/vim-scouter
* https://github.com/junegunn/fzf.vim
* https://github.com/vim-denops/denops.vim
* https://github.com/flow6852/dps-mergeqf
* https://github.com/flow6852/dps-taskrunner
* https://github.com/rust-lang/rust.vim
* https://github.com/LumaKernel/coqpit.vim
* https://github.com/qnighy/satysfi.vim
* https://github.com/lervag/vimtex
* https://github.com/williamboman/mason.nvim
* https://github.com/williamboman/mason-lspconfig.nvim
* https://github.com/neovim/nvim-lspconfig
* https://github.com/Shougo/ddc-nvim-lsp
* https://github.com/prabirshrestha/vim-lsp
* https://github.com/mattn/vim-lsp-settings
* https://github.com/shun/ddc-vim-lsp
* https://github.com/Shougo/ddc.vim
* https://github.com/Shougo/pum.vim
* https://github.com/Shougo/ddc-source-around
* https://github.com/LumaKernel/ddc-source-file
* https://github.com/tani/ddc-path
* https://github.com/matsui54/ddc-buffer 
* https://github.com/Shougo/ddc-source-cmdline
* https://github.com/Shougo/ddc-source-cmdline-history
* https://github.com/Shougo/ddc-source-omni
* https://github.com/Shougo/ddc-source-line
* https://github.com/Shougo/ddc-source-input
* https://github.com/Shougo/ddc-source-rg
* https://github.com/matsui54/denops-popup-preview.vim
* https://github.com/matsui54/denops-signature_help 
* https://github.com/hrsh7th/vim-vsnip
* https://github.com/hrsh7th/vim-vsnip-integ
* https://github.com/Shougo/ddc-ui-native
* https://github.com/Shougo/ddc-ui-pum
* https://github.com/tani/ddc-fuzzy 
* https://github.com/matsui54/ddc-filter_editdistance
* https://github.com/Shougo/ddc-converter_remove_overlap
* https://github.com/Shougo/ddc-sorter_rank
* https://github.com/Shougo/ddc-matcher_head
* https://github.com/Shougo/ddu.vim
* https://github.com/Shougo/ddu-ui-ff
* https://github.com/Shougo/ddu-ui-filer
* https://github.com/Shougo/ddu-source-file
* https://github.com/Shougo/ddu-source-file_rec
* https://github.com/Shougo/ddu-source-buffer
* https://github.com/Shougo/ddu-source-rg
* https://github.com/Shougo/ddu-source-line
* https://github.com/matsui54/ddu-source-help
* https://github.com/Shougo/ddu-source-register
* https://github.com/mikanIchinose/ddu-source-markdown
* https://github.com/liquidz/ddu-source-custom-list
* https://github.com/flow6852/ddu-source-qf
* https://github.com/flow6852/ddu-source-url
* https://github.com/kamecha/ddu-source-window
* https://github.com/flow6852/ddu-source-vim_variable
* https://github.com/flow6852/ddu-source-vim_option
* https://github.com/flow6852/ddu-source-vim_function
* https://github.com/flow6852/ddu-source-vim_event
* https://github.com/flow6852/ddu-source-vim_command
* https://github.com/kyoh86/ddu-source-quickfix_history
* https://github.com/Shougo/ddu-filter-matcher_substring
* https://github.com/Shougo/ddu-filter-matcher_relative
* https://github.com/Shougo/ddu-filter-converter_display_word
* https://github.com/yuki-yano/ddu-filter-fzf
* https://github.com/matsui54/ddu-filter-fzy
* https://github.com/Shougo/ddu-kind-file
* https://github.com/4513ECHO/ddu-kind-url
* https://github.com/flow6852/ddu-kind-vim_type
* https://github.com/Shougo/ddu-column-filename
* https://github.com/flow6852/dps-atcoder-facilitator
* https://github.com/kat0h/bufpreview.vim
* https://github.com/thinca/vim-showtime
