#!/bin/bash

echo "Welcome to my linking script !"

ln -si ~/.config/other_dotfiles/.zshrc ~/.zshrc
ln -si ~/.config/other_dotfiles/.gitconfig ~/.gitconfig
ln -si ~/.config/other_dotfiles/.emacs ~/.emacs

read -p "Creating greeter user ? [y/N]" yesno
if [ "$yesno" = "y" ]
then
  sudo useradd -G video greeter 
fi

echo "Add samuel to video..."
sudo usermod -a -G video samuel

echo "Enabling basic services..."
sudo systemctl enable dhcpcd bluetooth iwd greetd

echo "Linking greetd"
sudo mkdir -p /etc/greetd
sudo ln -i ~/.config/other_dotfiles/greetd/* /etc/greetd/
