#!/bin/bash

install_packages() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "Linux..."
        sudo apt install -y vim curl
        sudo apt install -y universal-ctags
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
vim +'CocInstall -sync coc-clangd|q'

echo "Done."
