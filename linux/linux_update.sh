#!/bin/bash

rm rf ~/.zshenv
cp .zshenv ~

# rm -r ~/.config
# mkdir ~/.config

# setting up zsh
rm -rf ~/.config/zsh
mkdir -p ~/.config/zsh
cp -r zsh/.* ~/.config/zsh

# setting up kitty
rm -rf ~/.config/kitty
mkdir -p ~/.config/kitty
cp -r kitty/* ~/.config/kitty

# setting up nvim
rm -rf ~/.config/nvim
mkdir -p ~/.config/nvim
cp -r nvim/* ~/.config/nvim
