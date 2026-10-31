#!/bin/bash

# setup dir
BASE=$(pwd)
echo ${BASE}
if [ ! -e "${BASE}/setup.sh" ]
then
    echo "please execute in dotvim/bin"
    exit 1
fi

cd ${HOME}
unlink .vimrc
ln -s ${BASE}/../vimrc .vimrc
unlink .vim
ln -s ${BASE}/../vim .vim
cd ${BASE}

# rc settings

mkdir -p ${HOME}/.config/denops_nvim
cd ${HOME}/.config/denops_nvim
ln -s ${BASE}/../init_denops.vim
cd ${BASE}

mkdir -p ${HOME}/.config/denops_vime
cd ${HOME}/.config/denops_vime
ln -s ${BASE}/../init_denops_vime.vim
cd ${BASE}

mkdir -p ${HOME}/.config/goda_vim
cd ${HOME}/.config/goda_vim
ln -s ${BASE}/../init_goda_vim.vim
cd ${BASE}
