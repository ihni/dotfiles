#!/bin/bash

rm -f ~/.zshenv
cp .zshenv ~

# rm -r ~/.config
# mkdir ~/.config

# setting up zsh
rm -rf ~/.config/zsh
mkdir -p ~/.config/zsh
cp -r zsh/.* ~/.config/zsh

# setting up tmux
rm -f ~/.tmux.conf
cp .tmux.conf ~

# setting up kitty
rm -rf ~/.config/kitty
mkdir -p ~/.config/kitty
cp -r kitty/* ~/.config/kitty

# setting up nvim
rm -rf ~/.config/nvim
mkdir -p ~/.config/nvim
cp -r nvim/* ~/.config/nvim
