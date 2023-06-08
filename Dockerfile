From archlinux

RUN cat /etc/pacman.d/mirrorlist.pacnew | grep tsukuba | sed -i 's/\#//g' /etc/pacman.d/mirrorlist
RUN pacman -Syyu --noconfirm
RUN pacman -Syy git vim neovim deno sudo unzip gcc ripgrep --noconfirm

RUN useradd -m user
RUN echo 'user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN su -c "curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" user
RUN su -c "mkdir -p ~/.config/nvim" user

# for nvim Plugin
RUN su -c "mkdir -p ~/.vim" user
COPY ./vimrc /home/user/.vimrc
COPY ./init.vim /home/user/.config/nvim/init.vim
COPY ./vim /home/user/.vim
RUN su -c "nvim -c PlugInstall -c qa" user
RUN sudo chown user:user -R /home/user/.vim
RUN sudo chown user:user -R /home/user/.vimrc
RUN sudo chown user:user -R /home/user/.config/nvim/init.vim

USER user
WORKDIR /home/user
