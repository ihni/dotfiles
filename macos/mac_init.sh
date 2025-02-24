#!/bin/bash

trap 'echo "an error occured at line $LINENO.  Exiting..."; exit 1' ERR

# functions
install_xcode() {
    if ! xcode-select -p &> /dev/null; then
        echo "xcode command line tools not found, installing..."
        xcode-select --install
        if [ $? -ne 0 ]; then
            echo "error installing xcode command line tools"
            echo "terminating script..."
            exit 1
        fi
    else
        echo "xcode command line tools already installed"
    fi
}

install_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "homebrew not found, installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        if [ $? -ne 0 ]; then
            echo "error installing homebrew"
            echo "terminating script..."
            exit 1
        fi
    else
        echo "homebrew is already installed"
    fi
}

install_packages() {
    local packages=("$@")
    for package in "${packages[@]}"; do
        echo "installing $package..."
        brew install $package
        if [ $? -ne 0 ]; then
            echo "error installing $package"
            echo "terminating script..."
            exit 1
        fi

    done
}

setup_zsh() {
    rm -rf ~/.zshenv
    cp .zshenv ~
    
    if ! command -v zsh &> /dev/null; then
        echo "zsh not found, installing..."
        brew install zsh
        if [ $? -ne 0 ]; then
            echo "error installing zsh"
            echo "terminating script..."
            exit 1
        fi
    fi

    if [ -z "$SHELL" ] || [ "$SHELL" != "$(which zsh)" ]; then
        echo "setting zsh as the default shell..."
        chsh -s "$(which zsh)"
        if [ $? -ne 0 ]; then
            echo "error setting up zsh as the default shell"
            echo "terminating script..."
            exit 1
        fi
        echo "zsh has now been set as the default shell"
    else
        echo "zsh is already the default shell"
    fi
}

setup_oh_my_zsh() {
    rm -rf ~/.oh-my-zsh

    echo "installing oh-my-zsh..."
    nohup sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &

    pid=$!
    wait $pid

    if [ $? -ne 0 ]; then
        echo "error installing oh-my-zsh"
        echo "terminating script..."
        exit 1
    fi
    echo "oh-my-zsh has now been installed"

    # installing plugins for zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/plugins/
    
    rm -rf ~/.config/zsh
    mkdir -p ~/.config/zsh
    cp -r zsh/.* ~/.config/zsh
}

setup_nvim() {
    if ! command -v nvim &> /dev/null; then
        echo "nvim wasn't installed or was corrupted, please reinstall"
        echo "terminating script..."
        exit 1
    fi

    rm -rf ~/.config/nvim
    mkdir -p ~/.config/nvim
    cp -r nvim/* ~/.config/nvim
    
    # installing packer and setting it up
    rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
        ~/.local/share/nvim/site/pack/packer/start/packer.nvim

    nvim +PackerSync +qa
}

setup_kitty() {
    rm -rf ~/.config/kitty
    mkdir -p ~/.config/kitty
    cp -r kitty/* ~/.config/kitty
}

#
# running script
#
packages=(
    "zsh" "neovim" "git"
    "wget" "kitty"
    "fastfetch"
)

install_xcode
install_homebrew
install_packages "${packages[@]}"

setup_zsh
setup_oh_my_zsh
setup_nvim
setup_kitty

#
#   done!
#

echo "finished running init script!"

clear

exec zsh
