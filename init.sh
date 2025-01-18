#!/bin/bash

rm  ~/.zshenv
cp .zshenv ~

rm -r ~/.config
mkdir ~/.config

# setting up zsh
mkdir -p ~/.config/zsh
cp zsh/.zshrc ~/.config/zsh

# settings up kitty
mkdir -p ~/.config/kitty
cp kitty/kitty.conf ~/.config/kitty
