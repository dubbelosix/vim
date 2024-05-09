#!/bin/bash

set -e
set -x

install_packages() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "Linux..."
        # remove annoying popup for daemon restart https://stackoverflow.com/questions/73397110/how-to-stop-ubuntu-pop-up-daemons-using-outdated-libraries-when-using-apt-to-i#comment131834051_73397970
        sudo sed -i "/#\$nrconf{restart} = 'i';/s/.*/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf
        curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
        sudo apt-get install -y vim clangd nodejs universal-ctags build-essential
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Mac..."
        brew install vim curl
        brew install --HEAD universal-ctags
    else
        echo "Unsupported!"
        exit 1
    fi
}

# install vim + deps
install_packages

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# copy vimrc
curl -o ~/.vimrc https://raw.githubusercontent.com/dubbelosix/vim/main/.vimrc

# install all plugins
vim +PlugInstall +qall

# install coc-clangd
vim +'CocInstall -sync coc-clangd' +qall

echo "Done."
