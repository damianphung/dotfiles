#!/usr/bin/env bash

sudo apt update
sudo apt upgrade

# Essentials
sudo apt install -y \
    build-essential \
    clang \
    clang-format \
    curl \
    cmake \
    doxygen \
    exuberant-ctags \
    gdb \
    git \
    gnupg \
    gparted \
    htop \
    nodejs \
    python3 \
    python3-pip \
    shellcheck \
    silversearcher-ag \
    tmux \
    tree \
    vim \
    libreadline6-dev \
    python-dev \
    python3-dev \
    python3-setuptools \
    gcc make \
    pkg-config autoconf automake \
    python3-docutils \
    libseccomp-dev \
    libjansson-dev \
    libyaml-dev \
    libxml2-dev \
    zsh
sudo npm install -g jslint
sudo ln -fs /usr/bin/node{js,}

if ! [ -f "$HOME/.vim/autoload/plug.vim" ]; then
    mkdir -p "$HOME/.vim/autoload"
    mkdir -p "$HOME/.vim/plugged"
    curl -fLo "$HOME/.vim/autoload/plug.vim" "https://raw.github.com/junegunn/vim-plug/master/plug.vim"
fi

## tmux
git clone "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"
cp -vf ./dotfiles/\.* "$HOME/"
cp -vf ./tmux_workspace/* "$HOME/.tmux/"
cp -vf "tmux.terminfo" "$HOME/tmux.terminfo"
sudo tic -x $HOME/tmux.terminfo


## universal ctags
cd ~/
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh 
./configure
make
sudo make install
cd ~/

# install zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
# Themes for zsh
git clone https://github.com/powerline/fonts.git
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts
cp -vf ./zshrc/.zshrc "$HOME/"

vim -c "PlugInstall"

/bin/cat exports/less_settings >> ~/.bashrc
/bin/cat exports/less_settings >> ~/.zshrc

echo "All done!"
echo "Note: Change terminal setting to use Ubuntu Mono derivative Powerline Regular / equivalent for mobaxterm to get fonts working if you are ssh-ing to this remote machine"
