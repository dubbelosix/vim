#!/bin/bash

# Install Vim (assuming Debian/Ubuntu, modify as needed for other distros)
sudo apt update && sudo apt install -y vim

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy your Vim configuration file
# For this step, ensure your .vimrc file is accessible, perhaps in a Git repository or downloadable via URL
curl -o ~/.vimrc https://raw.githubusercontent.com/dubbelosix/vim/master/.vimrc

# Install plugins via vim-plug
vim +PlugInstall +qall

echo "Vim and plugins installed successfully."
