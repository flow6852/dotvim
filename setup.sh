#!/bin/bash

# setup dir
BASE=$(pwd)
echo ${BASE}
if [ ! -e "${BASE}/setup.sh" ]
then
    echo "please execute in dotvim"
    exit 1
fi

cd ${HOME}
ln -s ${BASE}/vimrc .vimrc
ln -s ${BASE}/vim .vim
cd ${BASE}

cd ${HOME}/.config/nvim
ln -s ${BASE}/init.vim
cd ${BASE}
