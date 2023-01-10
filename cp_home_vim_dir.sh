#!/bin/bash

Vimdirs=("filetype.vim" "ftplugin" "snippets" "vsnip" "available" "enable-nvim" "enable-vim")
Homedirs=("vimrc")
Nvimdirs=("init.vim")
OtherDirs=("")

Repository="flow6852/vim-neovim-test-env"

pwd="$(pwd)"

if [ "$(basename ${pwd})" != "$(basename ${Repository})" ]  && [ "$(git remote get-url origin | cut -f2 -d':')" != "${Repository}" ]
then
    echo "run only :: ./cp_home_vim_dir.sh"
    exit 1
fi

for i in ${Homedirs[@]}
do
    cp ${HOME}/.${i} ${i}
done

rm -rf ./vim && mkdir -p ./vim
for i in ${Vimdirs[@]}
do
    cp -r ${HOME}/.vim/${i} ./vim/${i}
done


for i in ${Nvimdirs[@]}
do
    cp ${HOME}/.config/nvim/${i} ${i}
done

# edit plugin lists in README.md FOR ME

cp README.tmp README.md

grep 'Plug' vim/available/10-vim-plug.vim | grep -v '" Plug' | sed "s/\( \)*Plug\( \)*'\([^']*\)'/\* https:\/\/github.com\/\3/g" >> README.md
