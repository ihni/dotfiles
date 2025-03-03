#!/bin/bash

# all my packages for fresh install
packages=(
    "zsh" "neovim" "git"
    "curl" "wget" "xclip"
    "fastfetch" "tmux"
    "bat"
)

trap 'echo "an error occured at line $LINENO. Exiting..."; exit 1' ERR

# functions
detect_package_manager() {
    if command -v apt &> /dev/null; then
        echo "apt"
    elif command -v apt-get &> /dev/null; then
        echo "apt-get"
    elif command -v yum &> /dev/null; then
        echo "yum"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    elif command -v pacman &> /dev/null; then
        echo "pacman"
    else
        echo "No supported package manager."
        exit 1
    fi
}

package_install_helper() {
    local manager=$1
    local package=$2

    case $manager in
        apt | apt-get)  sudo apt update && sudo apt install -y $package ;;
        yum)            sudo yum install -y $package ;;
        dnf)            sudo dnf install -y $package ;;
        pacman)         sudo pacman -Syu --noconfirm $package ;;
        *)              echo "unsupported package manager: $manager" && exit 1;;
    esac

    if [ $? -ne 0 ]; then
        echo "error installing $package"
        echo "terminating script..."
        exit 1
    fi
}

install_packages() {
    local manager=$1
    shift
    local packages=("$@")
    for package in "${packages[@]}"; do
        echo "installing $package..."
        package_install_helper $manager $package
    done
}

setup_zsh() {
    rm -rf ~/.zshenv
    cp .zshenv ~

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
    echo "oh-my-zsh has now been installed."
    
    # installing plugins for zsh
    rm -rf ~/.oh-my-zsh/plugins/zsh-autosuggestions
    rm -rf ~/.oh-my-zsh/plugins/zsh-syntaax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting

    rm -rf ~/.config/zsh
    mkdir -p ~/.config/zsh
    cp -r zsh/.* ~/.config/zsh
}

setup_tmux() {
    rm -rf ~/.tmux
    rm -f ~/.tmux.conf

    cp .tmux.conf ~ 

    # installing tpm and setting it up
    # prefix + I to install packages
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
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

manager=$(detect_package_manager)

install_packages $manager "${packages[@]}"

setup_zsh
setup_oh_my_zsh
setup_tmux
setup_nvim
setup_kitty

#
#   Done!
#
echo "Finished running init script!"
echo "Restarting terminal!!"

clear
rm -rf nohup.out 

exec zsh
