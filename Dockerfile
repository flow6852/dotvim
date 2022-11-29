From archlinux
RUN pacman -Syyu --noconfirm
RUN cat /etc/pacman.d/mirrorlist.pacnew | grep tsukuba | sed -i 's/\#//g' /etc/pacman.d/mirrorlist
RUN pacman -Syy git neovim deno sudo texlive-most texlive-lang biber lua --noconfirm

RUN useradd -m user
RUN echo 'user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN su -c "curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" user
RUN su -c "mkdir -p ~/.config/nvim" user

# for nvim Plugin
RUN su -c "mkdir -p ~/.vim/available" user
COPY ./vim/available/10-vim-plug.vim /home/user/.vim/available/10-vim-plug.vim
RUN su -c "mkdir ~/.vim/enable-nvim && cd ~/.vim/enable-nvim && ln -s ../available/10-vim-plug.vim" user
COPY ./vimrc /home/user/.vimrc
COPY ./init.vim /home/user/.config/nvim/init.vim
RUN su -c "nvim -c PlugInstall -c qa" user
COPY ./vim /home/user/.vim
RUN sudo chown user:user /home/user/.vim

USER user
WORKDIR /home/user
